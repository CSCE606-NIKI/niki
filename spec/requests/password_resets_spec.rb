require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/password_resets/new"
      expect(response).to have_http_status(:success)
    end
  end

  # Assuming you have set up RSpec and FactoryBot for testing

# In your password_resets_spec.rb or a similar test file

  describe "POST /password/reset" do
    context "when a user with the given email exists" do
      let(:user) { create(:user, email: "user@example.com") }

      it "sets a flash message" do
        post "/password/reset", params: { email: user.email }
        expect(flash[:alert]).to eq('If an account with that email was found, we have sent a link to reset the password')
      end

      it "redirects to the login page" do
        post "/password/reset", params: { email: user.email }
        expect(response).to redirect_to(login_path)
      end

      it "sets a flash message" do
        post "/password/reset", params: { email: "nonexistent@example.com" }
        expect(flash[:alert]).to eq('If an account with that email was found, we have sent a link to reset the password')
      end

      it "redirects to the login page" do
        post "/password/reset", params: { email: "nonexistent@example.com" }
        expect(response).to redirect_to(login_path)
      end
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
  
end