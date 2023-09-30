require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/password_resets/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/password_resets/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /password/reset" do
    it "returns http success" do
      post '/password/reset'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /password/reset/edit" do
    let(:user) { create(:user) }
    let(:token) { user.signed_id(purpose: 'password_reset', expires_in: 30.minutes) }

    it "returns http success with a valid token" do
      get "/password/reset/edit", params: { token: token }
      expect(response).to have_http_status(:success)
    end
  end

  # describe "PATCH /password/reset/edit" do
  #   let(:user) { create(:user) }
  #   let(:token) { user.signed_id(purpose: 'password_reset', expires_in: 30.minutes) }
  #   let(:new_password) { "new_password_here" }
  
  #   it "returns http success and updates the user's password" do
  #     user.reset_password_token = token
  #     user.save(validate: false) # Skip password validations
  #     patch "/password/reset/edit", params: {
  #       token: token,
  #       user: {
  #         password: new_password,
  #         password_confirmation: new_password
  #       }
  #     }
  
  #     expect(response).to have_http_status(:success)
  #     expect(user.reload.authenticate(new_password)).to be_truthy
  #   end
  # end
  
end