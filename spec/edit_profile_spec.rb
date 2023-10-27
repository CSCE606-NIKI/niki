require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  let(:user) { User.create!(username: 'ExistingUsername', email: 'existing@example.com', password: 'password1234') }
  let(:sample_image) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'sample.jpg'), 'image/jpg') }
  
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #edit' do
    it 'assigns the current user to @user' do
      get :edit
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:valid_attributes) { { username: 'NewUsername', email: 'newemail@example.com', profile_pic: sample_image } }

      it 'updates the user attributes and attaches the profile picture' do
        patch :update, params: { user: valid_attributes }
        user.reload
        expect(user.username).to eq('NewUsername')
        expect(user.email).to eq('newemail@example.com')
        expect(user.profile_pic).to be_attached
      end

      it 'redirects to the dashboard with a success notice' do
        patch :update, params: { user: valid_attributes }
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq('Profile updated successfully.')
      end
    end
    
    context 'with invalid attributes' do
      let(:invalid_attributes) { { username: '', email: 'newemail@example.com' } } # username is intentionally left blank
    
      it 'does not update the user attributes' do
        patch :update, params: { user: invalid_attributes }
        user.reload
        expect(user.username).not_to eq('')
        expect(user.email).not_to eq('newemail@example.com')
      end
    
      it 'renders the edit view' do
        patch :update, params: { user: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    
      it 'adds errors to the @user object' do
        patch :update, params: { user: invalid_attributes }
        expect(assigns(:user).errors).to be_present
      end
    end
    
    end
end
