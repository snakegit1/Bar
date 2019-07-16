class UsersController < ApplicationController

    def amnesia
        @token = params[:token]

        if !@token.nil? && !@token.blank?
            @user = User.find_by(:reset_password_token => @token)
            
            redirect_to "http://www.box-free.com" if @user.nil?

            if !@user.nil? && !@user.email.nil?
                @error = ""
                @success = ""

                if request.post?

                    if user_params[:password] == user_params[:password_confirmation]
                        @success = "La contraseña ha sido actualizada da manera exitosa."
                        @user.password = user_params[:password]
                        @user.reset_password_token = ""
                        @user.save
                    else
                        @error = "Las contraseñas no coinciden. Intente nuevamente."
                    end

                end
            else
                @error = "EL enlace de perdida de contraseña ha expirado. Intente nuevamente solicitar su nuevo enlace."
                @success = ""
            end
        else
            @error = "EL enlace de perdida de contraseña ha expirado. Intente nuevamente solicitar su nuevo enlace."
            @success = ""
        end
    end


    private
    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

end
