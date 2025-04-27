module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        before_action :configure_permitted_parameters, only: [:create]

        def create
          build_resource(sign_up_params)

          resource.save
          yield resource if block_given?
          respond_with resource
        end

        private

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: {
              message: 'Signed up successfully.',
              user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }, status: :created
          else
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :first_name, :last_name, :password, :password_confirmation])
        end

        def sign_up_params
          params.require(:user).permit(:email, :username, :first_name, :last_name, :password, :password_confirmation)
        end

        def after_sign_up_path_for(resource)
          nil
        end
      end
    end
  end
end
