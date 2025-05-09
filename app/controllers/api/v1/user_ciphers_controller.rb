class Api::V1::UserCiphersController < ApplicationController
  def create
    user_cipher = UserCipher.new(user_cipher_params)

    if user_cipher.save
      render json: { status: 'success', data: user_cipher }, status: :created
    else
      render json: { status: 'error', errors: user_cipher.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_cipher_params
    params.require(:user_cipher).permit(:user_id, :cipher_id, :time, :won)
  end
end
