require 'rails_helper'

describe SessionsController, type: :controller do
  let(:user) { create(:user) } 

  describe 'POST #create' do
    it 'logs in with valid email and password' do
      post :create, params: { identifier: user.email, password: user.password }
      expect(cookies[:auth_token]).to eq(user.auth_token)
      expect(response).to redirect_to(dashboard_path(user.id)) 
    end
    
    it 'logs in with valid username and password' do
        post :create, params: { identifier: user.username, password: user.password }
        expect(cookies[:auth_token]).to eq(user.auth_token)
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
      cookies[:auth_token] = user.auth_token
      delete :destroy
      # Deleting a cookie is not as simple as deleting a session variable
      # When you delete a cookie, instead of just deleting the variable
      # Rails sets the response header to a special value that tells the browser to delete the cookie
      # Check that the response header sets auth_token to an empty string
      expect(response.header['Set-Cookie']).to match(/^auth_token=;/)
      expect(response).to redirect_to(login_path) 
    end
  end
  describe 'GET #new' do
    it 'already logged in user' do
      cookies[:auth_token] = user.auth_token
      get :new
      expect(response).to redirect_to(dashboard_path) 
    end
  end

  describe 'GET #admin_new' do
    it 'already logged in user' do
      cookies[:auth_token] = user.auth_token
      get :admin_new
      expect(response).to render_template('admin/admin_login') 
    end
  end

  describe 'POST #admin_create' do
    it 'logs in with valid email and password' do
      post :admin_create, params: { username: user.username, password: user.password }
      expect(cookies[:auth_token]).to eq(user.auth_token)
      expect(response).to redirect_to(admin_path(user.id)) 
    end

    it 'does not log in with invalid password' do
      post :admin_create, params: { username: user.username, password: 'wrong_password' }
      expect(flash[:danger]).to eq('Invalid credentials') 
      expect(response).to render_template('admin/admin_login')
    end
  end

  describe 'DELETE #admin_destroy' do
    it 'logs out the user' do
      cookies[:auth_token] = user.auth_token
      delete :admin_destroy
      expect(response.header['Set-Cookie']).to match(/^auth_token=;/)
      expect(response).to redirect_to(admin_login_path) 
    end
  end
end

# describe MyController do
#   let(:cookies) { mock('cookies') }
#   context "when my page is visited" do
#     it "should delete my cookie" do
#       controller.stub!(:cookies).and_return(cookies)
#       cookies.should_receive(:delete).with(cookie, :domain => '.mydomain.com')
#       get "my_action"
#     end
#   end
# end 
