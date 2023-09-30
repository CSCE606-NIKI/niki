
require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let!(:user) { create(:user, email: 'valid@example.com') }

  describe 'GET #new' do
    it 'renders the new password reset form' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'sends a password reset email for a valid email' do
      post :create, params: { email: 'valid@example.com' }
      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to include('If an account with that email was found, we have sent a link to reset the password')
    end

    it 'displays a flash message for an invalid email' do
      post :create, params: { email: 'invalid@example.com' }
      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to include('If an account with that email was found, we have sent a link to reset the password')
    end
  end

  describe "GET #edit" do
    context "when the token is valid" do
      it "responds successfully" do
        user = create(:user)
        token = user.signed_id(purpose: 'password_reset')

        get :edit, params: { token: token }

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    context "when the password and confirmation are valid" do
      it "updates the user's password and redirects to the login page" do
        user = create(:user)
        token = user.signed_id(purpose: 'password_reset')

        put :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'new_password' } }

        expect(user.reload.authenticate('new_password')).to be_truthy
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('Your password was reset succesfully. Please log in.')
      end
    end

    context "when the token is invalid" do
      it "redirects to the new password reset page" do
        put :update, params: { token: 'invalid_token', user: { password: 'new_password', password_confirmation: 'new_password' } }

        expect(response).to redirect_to('/password/reset')
        expect(flash[:alert]).to eq('Your token has expired. Please try again')
      end
    end
  end

end

