class Api::GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :destroy]
  before_action :authenticate_user!

  before_action :isAdmin, only: [:update]
  before_action :isAdminOrSuperAdmin, only: [:create, :destroy]

  def index
    @gifts = Gift.all
    if params[:user_id]
      @gifts = @gifts.where(user_id: params[:user_id], pub_id: params[:pub_id])
    end
  end

  def show
  end

  def create
    pub_drink = PubDrink.find_by(id: gift_params[:drink_id])
    
    @gift = Gift.new(user_id: gift_params[:user_id], pub_id: gift_params[:pub_id], drink_id: pub_drink.drink.id)

    if @gift.save
      render :show, status: :created, location: api_pub_drink_path(@gift)
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @gift.destroy
    head :no_content
  end

  private

    def isAdminOrSuperAdmin
      (current_user.admin? || current_user.super_admin?)
    end

    def set_gift
      @gift = Gift.find(params[:id])
    end

    def gift_params
      params.require(:gift).permit(:drink_id, :user_id, :pub_id, :gift_name, :status)
    end
end
