# app/controllers/users/registrations_controller.rb
module Api
  module V1
    module Users
      class Users::RegistrationsController < Devise::RegistrationsController
        private
      
        def sign_up_params
          params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
        end
      
        def account_update_params
          params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :current_password)
        end
      end
    end
  end
end