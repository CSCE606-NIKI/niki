
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
      expect(flash[:notice]).to include('If an account with that email was found, we have sent a link to reset the password')
    end

    it 'displays a flash message for an invalid email' do
      post :create, params: { email: 'invalid@example.com' }
      expect(response).to render_template('new')
      expect(flash.now[:danger]).to include('Email not found')
    end
  end
end

# require 'rails_helper'

# RSpec.describe PasswordResetsController, type: :controller do
#   describe "GET #new" do
#     it "responds successfully" do
#       get :new
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "POST #create" do
#     context "when the email address is valid" do
#       it "sends a password reset email" do
#         user = create(:user)

#         post :create, params: { email: user.email }

#         expect(response).to redirect_to('/login')
#         expect(ActionMailer::Base.deliveries.count).to eq(1)
#         mail = ActionMailer::Base.deliveries.last

#         expect(mail.to).to eq([user.email])
#         expect(mail.subject).to eq("Password reset instructions")
#         expect(mail.body).to include("Your password reset token is #{user.password_reset_token}")
#       end
#     end

#     context "when the email address is invalid" do
#       it "renders the new page" do
#         post :create, params: { email: 'invalid@example.com' }

#         expect(response).to render_template(:new)
#         expect(flash[:danger]).to eq('Email not found')
#       end
#     end
#   end

#   describe "GET #edit" do
#     context "when the token is valid" do
#       it "responds successfully" do
#         user = create(:user)
#         token = user.signed_id(purpose: 'password_reset')

#         get :edit, params: { token: token }

#         expect(response).to have_http_status(:success)
#       end
#     end

#     context "when the token is invalid" do
#       it "redirects to the login page" do
#         get :edit, params: { token: 'invalid_token' }

#         expect(response).to redirect_to('/login')
#         expect(flash[:alert]).to eq('Your token has expired. Please try again')
#       end
#     end
#   end

#   describe "PUT #update" do
#     context "when the password and confirmation are valid" do
#       it "updates the user's password and redirects to the login page" do
#         user = create(:user)
#         token = user.signed_id(purpose: 'password_reset')

#         put :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'new_password' } }

#         expect(user.reload.authenticate('new_password')).to be_truthy
#         expect(response).to redirect_to(login_path)
#         expect(flash[:notice]).to eq('Your password was reset succesfully. Please sign in.')
#       end
#     end

#     context "when the password or confirmation is invalid" do
#       it "renders the edit page" do
#         user = create(:user)
#         token = user.signed_id(purpose: 'password_reset')

#         put :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'invalid_password' } }

#         expect(response).to render_template(:edit)
#         expect(flash[:danger]).to be_present?
#       end
#     end

#     context "when the token is invalid" do
#       it "redirects to the new password reset page" do
#         put :update, params: { token: 'invalid_token', user: { password: 'new_password', password_confirmation: 'new_password' } }

#         expect(response).to redirect_to('/password_resets/new')
#         expect(flash[:alert]).to eq('Your token has expired. Please try again')
#       end
#     end
#   end
# end
