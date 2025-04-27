module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        # 🛠 Add this create method
        def create
          user = User.find_by(email: sign_in_params[:email])

          if user&.valid_password?(sign_in_params[:password])
            sign_in(:user, store: false)
            render json: {
              message: 'Logged in successfully.',
              user: UserSerializer.new(user).serializable_hash[:data][:attributes]
            }, status: :ok
          else
            render json: { error: 'Invalid Email or Password' }, status: :unauthorized
          end
        end

        private

        def respond_with(resource, _opts = {})
          render json: {
            message: 'Logged in successfully.',
            user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
        end

        def respond_to_on_destroy
          current_user ? 
            render(json: { message: "Logged out successfully." }, status: :ok) :
            render(json: { message: "Couldn't find an active session." }, status: :unauthorized)
        end

        def sign_in_params
          params.permit(:email, :password)
        end
      end
    end
  end
end