class Api::RegistrationsController < ApplicationController

  before_action :isSuperAdmin, :except => [:create]

  def create
    @user = User.new(user_params)
    @user.admin = true

    if @user.save
      # @user.confirm!
      @user.send_welcome_email_admin if params[:send_email]
      render json: {success: true}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :lastname, :only_admins, :send_email, :password, :password_confirmation, :born_date, :genre)
  end

  def isSuperAdmin
    current_user.super_admin?
  end

end