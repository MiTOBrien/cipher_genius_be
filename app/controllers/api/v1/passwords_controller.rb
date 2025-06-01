class Api::V1::PasswordsController < ApplicationController
  def create
    email = params[:email]
    user = User.find_by(email: email)
    if user.present?
      user.send_reset_password_instructions
      render json: { message: 'Password reset instructions sent.' }, status: :ok
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end

  def update
    user = User.reset_password_by_token(reset_password_params)
    if user.errors.empty?
      render json: { message: 'Password has been reset.' }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reset_password_params
    params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
  end
end
