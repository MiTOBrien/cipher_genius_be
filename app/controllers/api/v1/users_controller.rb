class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def update
    if current_user.update(user_params)
      render json: { user: current_user }, status: :ok
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def change_password
    # Validate current password
    unless current_user.valid_password?(password_change_params[:current_password])
      return render json: { error: 'Current password is incorrect.' }, status: :unauthorized
    end

    # Validate new password confirmation
    if password_change_params[:new_password] != password_change_params[:new_password_confirmation]
      return render json: { error: 'New password confirmation does not match.' }, status: :unprocessable_entity
    end

    # Update password
    if current_user.update(password: password_change_params[:new_password])
      render json: { message: 'Password changed successfully.' }, status: :ok
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end

  def password_change_params
    params.permit(:current_password, :new_password, :new_password_confirmation)
  end
end