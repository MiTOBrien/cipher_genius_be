require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user, name: 'Old Name', username: 'old_username') }
  let(:headers) { auth_headers_for(user) }

  describe "put /api/v1/users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            name: "New Name",
            username: "new_username"
          }
        }
      end

      it "updates the user and returns success" do
        put "/api/v1/users/update", params: valid_params, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["user"]["name"]).to eq("New Name")
        expect(user.reload.name).to eq("New Name")
      end
    end

    context "without a valid JWT token" do
      let(:valid_params) do
        {
          user: {
            name: "Should Not Work",
            username: "unauthorized_user"
          }
        }
      end
    
      it "returns unauthorized status" do
        put "/api/v1/users/update", params: valid_params # no headers
    
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
