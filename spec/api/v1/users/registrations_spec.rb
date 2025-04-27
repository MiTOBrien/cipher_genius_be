# spec/requests/api/v1/users/registrations_spec.rb
require 'rails_helper'

RSpec.describe "User Registration", type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) do
      {
        username: "newuser",
        email: "newuser@example.com",
        password: "SuperSecure123!",
        password_confirmation: "SuperSecure123!"
      }
    end

    let(:invalid_attributes) do
      {
        username: "newuser",
        email: "notanemail",
        password: "123",
        password_confirmation: "321"
      }
    end

    context "with valid parameters" do
      it "creates a new user and returns success" do
        post "/api/v1/users", params: { user: valid_attributes }, as: :json
        puts response.body

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)

        expect(json_response["message"]).to eq("Signed up successfully.")
        expect(json_response["user"]["email"]).to eq("newuser@example.com")
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and returns errors" do
        post "/api/v1/users", params: { user: invalid_attributes }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)

        expect(json_response["errors"]).to be_present
      end
    end
  end
end
