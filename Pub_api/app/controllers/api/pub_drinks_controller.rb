class Api::PubDrinksController < ApplicationController
  before_action :set_pub_drink, only: [:show, :update, :destroy, :enable_pub_category]
  before_action :authenticate_user!
  #
  before_action :isAdminOrSuperAdmin, only: [:update, :create, :destroy]

  def index
    if (current_user.admin?)
      @api_pub_drinks = PubDrink.joins(:pub).where('pubs.user_id = ?', current_user.id)
    elsif (current_user.super_admin?)
      if params[:pub_id]
        @api_pub_drinks = Pub.find(params[:pub_id]).pub_drinks.all
      else
        @api_pub_drinks = PubDrink.all
      end
    else
      @api_pub_drinks = PubDrink.all
    end
  end

  def show
  end

  def create

    @api_pub_drink = PubDrink.new(pub_drink_params)

    if (current_user.admin? && (@api_pub_drink.pub.user_id != current_user.id))
      render json: {errors: ['Not Allowed']}, status: :unauthorized
      return
    end

    if @api_pub_drink.save
      render :show, status: :created, location: api_pub_drink_path(@api_pub_drink)
    else
      render json: @api_pub_drink.errors, status: :unprocessable_entity
    end
  end


  def update
      if @api_pub_drink.update(pub_drink_params)
        render :show, status: :ok, location: api_pub_drink_path(@api_pub_drink)
      else
        render json: @api_pub_drink.errors, status: :unprocessable_entity
      end

  end

  def enable_pub_category
    if @api_pub_drink.update(enable: !@api_pub_drink.enable)
      @pubs = Pub.where(:user_id => current_user.id, enable: true).order(:order_index)
      render :'api/pubs/index', status: :ok, location: api_drinks_path()
    else
      render json: @api_pub_drink.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @api_pub_drink.destroy
    head :no_content
  end

  private

    def isAdminOrSuperAdmin
      (current_user.admin? || current_user.super_admin?)
    end

    def set_pub_drink
        @api_pub_drink = PubDrink.find(params[:id])
    end


    def pub_drink_params
      params.require(:pub_drink).permit(:drink_id, :price, :pub_id)
    end
end
