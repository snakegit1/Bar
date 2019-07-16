class Api::PubsController < ApplicationController
  before_action :set_pub, only: [:show, :update, :destroy, :enable_pub]
  before_action :authenticate_user!

  before_action :isAdmin, only: [:update]
  before_action :isSuperAdmin, only: [:create, :destroy]

  def index
    if current_user.super_admin?
      @pubs = Pub.all.order(:order_index)
    elsif current_user.admin?
      @pubs = Pub.where(:user_id => current_user.id, enable: true).order(:order_index)
    else
      @pubs = Pub.all.order(:order_index)
    end
  end

  def show

  end


  def create
    @pub = Pub.new(pub_params)

    if @pub.save
      render :show, status: :created, location: api_pub_path(@pub)
    else
      format.json { render json: @pub.errors, status: :unprocessable_entity }
    end
  end

  def update
      if @pub.update(pub_params)
        render :show, status: :ok, location: api_pub_path(@pub)
      else
        render json: @pub.errors, status: :unprocessable_entity
      end
  end

  def enable_pub
    if @pub.update(enable: !@pub.enable)
      render :show, status: :ok, location: api_pub_path(@pub)
    else
      render json: @pub.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pub.destroy
    head :no_content
  end

  def upload_logo
    begin

      if params[:pub_id] && params[:pub_logo_base64] && params[:pub_logo_filename] && params[:pub_logo_filetype]

        if current_user.admin && current_user.pub.id != params[:pub_id]
          render json: 'error', status: 403
        else
          @pub = Pub.find(params[:pub_id])
        end

        data = StringIO.new(Base64.decode64(params[:pub_logo_base64]))
        data.class.class_eval { attr_accessor :original_filename, :content_type }
        data.original_filename = params[:pub_logo_filename]
        data.content_type = params[:pub_logo_filetype]

        @pub.image_logo = data
        if @pub.save
          render :show, status: :ok, location: api_pub_path(@pub)
        else
          render json: 'error', status: :unprocessable_entity
        end

      else
        render json: 'error', status: :unprocessable_entity
      end
    rescue => ex
      logger.debug ex.to_s
      render json: 'error', status: :unprocessable_entity
    end

  end

  private
    def set_pub
      @pub = Pub.find(params[:id])
    end

    def isAdmin
      current_user.admin?
    end

    def isSuperAdmin
      current_user.super_admin?
    end

    def pub_params
      params.require(:pub).permit(:name, :description, :location, :telephone1,
        :telephone2, :user_id, :bank_account_rut, :bank_name, :bank_account_type, :bank_account_email,
        :bank_account_number, :order_index)
    end
end
