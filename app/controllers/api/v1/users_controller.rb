class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def update
    if current_user.update(user_params)
      render json: { user: current_user }, status: :ok
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end