require 'rails_helper'

RSpec.describe AdminController, type: :controller do
    let(:user) { create(:user, :admin => true) }
    let(:user2) { create(:user, :admin => false) }
    let(:user3) { create(:user, :admin => true) }
    let(:user4) { create(:user, :admin => false) }

    describe 'GET #index' do
        it 'renders admin page for admin login' do
            sign_in_user(user)
            get :index
            expect(response).to render_template('index')
        end
        it 'redirects to root path if user is not admin' do
            sign_in_user(user4)
            get :index
            expect(response).to render_template('logout')
            expect(flash[:error]).to eq('You do not have access to this resource. Log out and try different credentials.')
        end
        it 'redirects to admin login path if user is not logged in' do
            get :index
            expect(response).to redirect_to(admin_login_path)
            expect(flash[:error]).to eq('You must be logged in to access the dashboard.')
        end
    end

    describe 'GET #user_overview' do
        it 'renders the user overview template' do
            sign_in_user(user)
            get :user_overview, params: { u: user2.id }
            expect(response).to render_template('user_overview')
            expect(assigns(:user)).to eq(user2)
        end
    end

    describe 'POST #change_user_role' do
        it 'changes the user role from standard to admin' do
            sign_in_user(user)
            post :change_user_role, params: { u: user2.id }
            user2.reload
            expect(user2.admin).to eq(true)
        end
        it 'changes the user role from admin to standard' do
            sign_in_user(user)
            post :change_user_role, params: { u: user3.id }
            user3.reload
            expect(user3.admin).to eq(false)
        end
    end

    describe 'POST #delete_user' do
        it 'deletes the user' do
            sign_in_user(user)
            post :delete_user, params: { u: user2.id }
            expect(User.exists?(user2.id)).to eq(false)
            expect(response).to redirect_to(admin_path)
        end
    end

    private
    def sign_in_user(user)
        allow(controller).to receive(:current_user).and_return(user)
    end
end