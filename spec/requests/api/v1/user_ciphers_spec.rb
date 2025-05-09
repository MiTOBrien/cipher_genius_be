require 'rails_helper'

RSpec.describe "UserCiphers", type: :request do
  describe "POST /user_ciphers/create" do
    let(:user) { create(:user) }
    let!(:cipher) { Cipher.create!(cipher: "Caesar Cipher") }

    let(:valid_params) do
      {
        user_cipher: {
          user_id: user.id,
          cipher_id: cipher.id,
          time: 95,
          won: true
        }
      }
    end

    it "creates a new user_cipher and returns success" do
      post "/api/v1/user_ciphers/create", params: valid_params

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)
      expect(json["status"]).to eq("success")
      expect(json["data"]["user_id"]).to eq(user.id)
      expect(json["data"]["cipher_id"]).to eq(cipher.id)
      expect(json["data"]["time"]).to eq(95)
      expect(json["data"]["won"]).to be true
    end

    it "returns errors with invalid data" do
      invalid_params = { user_cipher: { user_id: nil, cipher_id: nil } }

      post "/api/v1/user_ciphers/create", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)
      expect(json["status"]).to eq("error")
      expect(json["errors"]).to include("User must exist", "Cipher must exist")
    end
  end
end
