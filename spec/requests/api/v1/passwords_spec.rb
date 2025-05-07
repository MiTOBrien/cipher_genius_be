require 'rails_helper'

RSpec.describe 'Password Reset', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'Password1!', password_confirmation: 'Password1!') }

  describe 'POST /password' do
    it 'sends reset instructions to valid email' do
      post '/password', params: { user: { email: user.email } }

      expect(response).to have_http_status(:ok)
      expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
    end

    it 'returns ok even for non-existent email (to prevent user enumeration)' do
      post '/password', params: { user: { email: 'nonexistent@example.com' } }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /password' do
    before do
      @raw_token = user.send_reset_password_instructions
    end
  
    it 'resets password with valid token' do
      put '/password', params: {
        user: {
          reset_password_token: @raw_token,
          password: 'NewPass123!',
          password_confirmation: 'NewPass123!'
        }
      }
  
      expect(response).to have_http_status(:ok)
      expect(user.reload.valid_password?('NewPass123!')).to be true
    end

    it 'fails with invalid token' do
      put '/password', params: {
        user: {
          reset_password_token: 'badtoken',
          password: 'NewPass123!',
          password_confirmation: 'NewPass123!'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'fails when passwords do not match' do
      put '/password', params: {
        user: {
          reset_password_token: @token,
          password: 'NewPass123!',
          password_confirmation: 'Mismatch123!'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
