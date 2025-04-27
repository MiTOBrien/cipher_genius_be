module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        def create
          user = User.find_by(email: sign_in_params[:email])

          if user&.valid_password?(sign_in_params[:password])
            sign_in(:user, user, store: false)  # <-- Pass user here!
            respond_with(user)                  # <-- Now it will use your respond_with
          else
            render json: { error: 'Invalid Email or Password' }, status: :unauthorized
          end
        end

        private

        def respond_with(resource, _opts = {})
          token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first

          render json: {
            message: 'Logged in successfully.',
            token: token,
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
