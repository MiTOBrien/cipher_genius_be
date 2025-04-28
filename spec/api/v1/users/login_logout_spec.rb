# spec/requests/api/v1/user_authentication_spec.rb

require 'rails_helper'

RSpec.describe "User Authentication (JWT)", type: :request do
  let(:password) {"Password123!"}
  let(:username) {"TestUser"}
  let(:user) { create(:user, password: password) }

  describe "POST /api/v1/users/sign_in" do
    context "with valid credentials" do
      it "returns a JWT token" do
        post "/api/v1/users/sign_in", params: {
          email: user.email,
          password: user.password,
        }, as: :json

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)

        expect(json['token']).to be_present
      end
    end

    context "with invalid credentials" do
      it "returns an error" do
        post "/api/v1/users/sign_in", params: {
          user: {
            email: user.email,
            password: "wrongpassword"
          }
        }, as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/users/sign_out" do
    it "revokes the JWT token" do
      post "/api/v1/users/sign_in", params: {
        email: user.email,
        password: user.password
      }, as: :json

      json = JSON.parse(response.body)
      token = json['token']

      delete "/api/v1/users/sign_out", headers: {
        'Authorization' => token
      }, as: :json

      expect(response).to have_http_status(:ok)
    end
  end
end
