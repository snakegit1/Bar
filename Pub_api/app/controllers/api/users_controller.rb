class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :isSuperAdmin, :except => [:facebook, :amnesia]

  def index
    if params[:only_admins]
      @users = User.where('admin = ? and super_admin = ?', true, false)
    else
      @users = User.where('admin = ? and super_admin = ?', false, false)
    end
  end

  def show
  end

  def facebook
    resource = User.find_by(:uid => user_facebook_params[:email])
    token = BCrypt::Password.create(SecureRandom.urlsafe_base64(nil, false))
    expiry = (Time.now + ::DeviseTokenAuth.token_lifespan).to_i

    # User does not exists
    if resource.nil?
      user = User.new(user_facebook_params)
      user.uid = user.email
      user.provider = "email"
      user.password = user_facebook_params_token[:token]
      user.confirmed_at = Time.now
      user.save      

      render json: {
        status: :ok
      }, status: :ok
      
    # User does exists
    else
      @client_id = SecureRandom.urlsafe_base64(resource.id, false)
      resource.password = user_facebook_params_token[:token]
      resource.save

      render json: {
        status: :ok
      }, status: :ok
    end

  end

  def amnesia
    render :amnesia, format: :html
  end

  def create
    @user = User.new(user_params)
    @user.admin = true

      if @user.save
        @user.confirm
        @user.send_welcome_email_admin if params[:send_email]
        render :show, status: :created, location: api_user_path(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  def update
      if @user.update(user_params)
        render :show, status: :ok, location: api_user_path(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def isSuperAdmin
      current_user.super_admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_facebook_params_token
      params.require(:user).permit(:email, :token)
    end

    def user_facebook_params
      params.require(:user).permit(:email, :name, :lastname, :born_date, :genre, :token)
    end

    def user_params
      params.require(:user).permit(:email, :name, :lastname, :only_admins, :send_email, :password, :password_confirmation, :born_date, :genre)
    end
end
