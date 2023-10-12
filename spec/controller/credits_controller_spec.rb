require 'rails_helper'

RSpec.describe CreditsController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET #new' do
    it 'assigns a new Credit to @credit' do
      sign_in_user(user) 
      get :new
      expect(assigns(:credit)).to be_a_new(Credit)
    end

    it 'renders the new template' do
      sign_in_user(user) 
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
        let(:valid_credit_attributes) do
            {
              credit_type: "Credit_type1",
              date: "2023-10-11",
              amount: 100,
              description: "Test Text"
            }
          end
      it 'creates a new credit' do
        sign_in_user(user) 
        expect do
          post :create, params: { credit: valid_credit_attributes }
        end.to change(Credit, :count).by(1)
      end

      it 'redirects to the dashboard path' do
        sign_in_user(user) 
        post :create, params: { credit: valid_credit_attributes }
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets a success flash message' do
        sign_in_user(user) 
        post :create, params: { credit: valid_credit_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      let(:invalid_credit_attributes) { attributes_for(:credit, amount: 0, credit_type: "Credit_type1") } # Replace with invalid credit attributes

      it 'does not create a new credit' do
        sign_in_user(user) 
        expect do
          post :create, params: { credit: invalid_credit_attributes }
        end.not_to change(Credit, :count)
      end

      it 'redirects to new_credit_path' do
        sign_in_user(user) 
        post :create, params: { credit: invalid_credit_attributes }
        expect(response).to redirect_to(new_credit_path)
      end

      it 'sets an error flash message' do
        sign_in_user(user) 
        post :create, params: { credit: invalid_credit_attributes }
        expect(flash[:error]).to be_present
      end
    end
  end
end

def sign_in_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end