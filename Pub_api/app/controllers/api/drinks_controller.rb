class Api::DrinksController < ApplicationController
  before_action :set_drink, only: [:show, :update, :destroy, :enable_drink]
  before_action :authenticate_user!

  def index
     @drinks = Drink.includes(:drink_category).where(enable: true).where(drink_categories: {enable: true})

  end

  def show
  end

  def new
    @drink = Drink.new
  end

  def edit
  end

  def create
    @drink = Drink.new(drink_params)

    if @drink.save
        render :show, status: :created, location: api_drink_path(@drink)
    else
        render json: @drink.errors, status: :unprocessable_entity
    end
  end

  def update
      if @drink.update(drink_params)
        render :show, status: :ok, location: api_drink_path(@drink)
      else
        render json: @drink.errors, status: :unprocessable_entity
      end
  end

  def enable_drink
    @drink_categories = DrinkCategory.where(enable: true)
    @include_drinks = true
    if @drink.update(enable: !@drink.enable)
      render :'api/drink_categories/index', status: :ok, location: api_drink_categories_path()
    else
      render json: @drink.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @drink.destroy
    head :no_content
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end

    def drink_params
      params.require(:drink).permit(:name, :description, :image => [:image_file_name, :image_file_size, :image_content_type, :image_updated_at])
    end
end
