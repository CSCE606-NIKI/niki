require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
    describe 'GET #index' do
      it 'redirects to renewal date page if renewal date is not set' do
        @user = User.create!(username: 'test', email: 'test@tamu.edu', password: 'password', password_confirmation: 'password', renewal_date: nil)
        cookies[:auth_token] = @user.auth_token
        get :index, params: {id: @user.id }
        expect(response).to redirect_to(renewal_date_user_path(@user)) 
      end
      it 'redirects to renewal date page if renewal date is on or before today' do
        @user = User.create!(username: 'test', email: 'test@tamu.edu', password: 'password', password_confirmation: 'password', renewal_date: Date.today)
        cookies[:auth_token] = @user.auth_token
        get :index, params: {id: @user.id }
        expect(response).to redirect_to(renewal_date_user_path(@user)) 
      end
    end
end