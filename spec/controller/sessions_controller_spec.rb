require 'rails_helper'

describe SessionsController, type: :controller do
  let(:user) { create(:user) } 

  describe 'POST #create' do
    it 'logs in with valid email and password' do
      post :create, params: { identifier: user.email, password: user.password }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(dashboard_path(user.id)) 
    end
    
    it 'logs in with valid username and password' do
        post :create, params: { identifier: user.username, password: user.password }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(dashboard_path(user.id))
      end

    it 'does not log in with invalid password' do
      post :create, params: { identifier: user.email, password: 'wrong_password' }
      expect(session[:user_id]).to be_nil
      expect(flash[:danger]).to eq('Invalid credentials') 
    end

    it 'check that it does not log in with non-existent email' do
      post :create, params: { identifier: 'nonexistent@gmail.com', password: 'password' }
      expect(session[:user_id]).to be_nil
      expect(flash[:danger]).to eq('Invalid credentials') 
    end

    it 'check that it does not log in with non-existent username' do
        post :create, params: { identifier: 'nonexistent', password: 'password' }
        expect(session[:user_id]).to be_nil
        expect(flash[:danger]).to eq('Invalid credentials') 
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user' do
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path) 
    end
  end
  describe 'GET #new' do
    it 'already logged in user' do
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to(root_path) 
    end
  end
end
