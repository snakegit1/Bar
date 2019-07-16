class Api::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  before_action :authenticate_user!
  
  # Transaction Statuses
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def index
    if current_user.super_admin?
      @orders = Order.includes(:user).order("id DESC")
      @orders = @orders.where(["created_AT BETWEEN ? AND ?", Time.zone.parse(params[:date_start]).beginning_of_day, Time.zone.parse(params[:date_end]).at_end_of_day ]) if !params[:date_start].nil? && !params[:date_end].nil?

      if !params[:limit].nil?
        @orders = @orders.limit(params[:limit])
      end

      @orders = @orders.order("id DESC")
    elsif current_user.admin?
      pub = Pub.find_by({id: params[:pub_id], user_id: current_user})
      @orders = Order.includes(:user).where(pub_id: pub.id)      
      @orders = @orders.where(["created_AT BETWEEN ? AND ?", Time.zone.parse(params[:date_start]).beginning_of_day, Time.zone.parse(params[:date_end]).at_end_of_day]) if !params[:date_start].nil? && !params[:date_end].nil?

      if !params[:limit].nil?
        @orders = @orders.limit(params[:limit])
      end
      
      @orders = @orders.order("id DESC")
    else
      @orders = Order.where(user_id: current_user.id, status: Order::STATUSES[:NOT_USED])
    end
  end

  def show
      @orders = Order.includes(:user).where(id: params[:id])
      @payment = Braintree::Transaction.find(@orders.last.token).credit_card_details
      render :index
  end

  def client_token
    @client_token = current_user.generate_client_token
  end

  def validate
    @order = Order.find_by(id: order_validation_params[:id], pub_id: order_validation_params[:pub_id], token: order_validation_params[:token])
    
    if @order.status == Order::STATUSES[:NOT_USED]
      @order.update(status: Order::STATUSES[:USED])
      @validated = true
    else
      @validated = false
    end

  end

  def create
    @order = {}
    @transaction_success = false
    total_price = Order.calculate_price(order_params[:pub_id], order_params[:drinks])

    result = Braintree::Transaction.sale(
      amount: total_price,
      merchant_account_id: "BoxFree_CLP",
      payment_method_nonce: order_params[:token],
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success? || result.transaction

      # When the transaction was succesfully
      if TRANSACTION_SUCCESS_STATUSES.include?(result.transaction.status)
    
        # We create the order
        @order = Order.create({
            user_id: current_user.id,
            pub_id: order_params[:pub_id],
            price: total_price,
            status: false, # 0 => not used, 1 => used
            ip: request.remote_ip,
            payment_method: "braintreepayments",
            token: result.transaction.id
        })

        # And we add drinks into the order
        order_params[:drinks].each do |drink|
          pub_drink = PubDrink.find_by({pub_id: order_params[:pub_id], id: drink[:id]})
          @order.orders_drink.create({
            drink_id: pub_drink.drink_id,
            price: pub_drink.price,
            quantity: drink[:quantity]
          })
        end
        
        # Voila! :)
        @transaction_success = true

        # We send an email
        begin
          UserMailer.orders(@order).deliver_now
        rescue
          logger.error "Transacción #{@order.id} no se pudo enviar el correo electrónico"
        end
      end

    end

  end

  def update
      if @credit_card.update(credit_card_params)
        render :show, status: :ok, location: api_credit_card_path(@credit_card)
      else
        render json: @credit_card.errors, status: :unprocessable_entity
      end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:pub_id, :token, drinks: [[:id, :quantity]])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_validation_params
      params.require(:order).permit(:id, :pub_id, :token)
    end
end
