class Api::DrinkCategoriesController < ApplicationController
  before_action :set_drink_category, only: [:show, :edit, :update, :destroy, :enable_category]
  before_action :authenticate_user!
  
  def index
    @drink_categories = DrinkCategory.all
    if params[:include_drinks]
      @include_drinks = true
    else
      @include_drinks = false
    end
  end

  def show

  end

  def create
    @drink_category = DrinkCategory.new(drink_category_params)

      if @drink_category.save
        render :show, status: :created, location: api_drink_category_path(@drink_category)
      else
        render json: @drink_category.errors, status: :unprocessable_entity
      end
  end

  def update
      if @drink_category.update(drink_category_params)
        render :index, status: :ok, location: api_drink_categories()
      else
        render json: @drink_category.errors, status: :unprocessable_entity
      end
  end

  def enable_category
    @category = DrinkCategory.find(params[:id])
    @drink_categories = DrinkCategory.all
    @include_drinks = true
    if @category.update(enable: !@category.enable)
      render :index, status: :ok, location: api_drink_categories_path()
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @drink_category.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink_category
      @drink_category = DrinkCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drink_category_params
      params.require(:drink_category).permit(:include_drinks, :name)
    end
end
