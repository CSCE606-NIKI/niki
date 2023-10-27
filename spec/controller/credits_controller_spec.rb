require 'rails_helper'

RSpec.describe CreditsController, type: :controller do
  let(:user) { create(:user) }
  let(:credit_type_without_carry_forward) { create(:credit_type_without_carry_forward) }
# Corrected usage to create a CreditType with carry forward enabled
  let(:credit_type_with_carry_forward) { create(:credit_type_with_carry_forward) }

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
              credit_type_id: credit_type_without_carry_forward.id,
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
      let(:invalid_credit_attributes) { attributes_for(:credit, amount: 0,  credit_type_id: credit_type_without_carry_forward.id) } # Replace with invalid credit attributes

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

    context 'with carry forward enabled' do
      it 'calculates the cumulative total of credits' do
        sign_in_user(user)

         # Create existing credits for a different year
        create(:credit, user: user, credit_type: credit_type_with_carry_forward, amount: 100, date: '2022-01-01')
        create(:credit, user: user, credit_type: credit_type_with_carry_forward, amount: 200, date: '2022-02-15')

        valid_credit_attributes = {
          credit_type_id: credit_type_with_carry_forward.id,
          date: '2023-10-11',
          amount: 100,
          description: 'Test Text'
        }

        expect do
          post :create, params: { credit: valid_credit_attributes }
        end.to change(Credit, :count).by(1)

        # Calculate the expected total for carry forward enabled
        expected_total = 400

        # Check the actual total in the database
        actual_total = user.credits.where(credit_type: credit_type_with_carry_forward).sum(:amount)
        
        expect(actual_total).to eq(expected_total)
      end

      it 'calculates the total for the current year only' do
        sign_in_user(user)

        # Create existing credits for a different year
        create(:credit, user: user, credit_type: credit_type_without_carry_forward, amount: 100, date: '2022-01-01')
        create(:credit, user: user, credit_type: credit_type_without_carry_forward, amount: 200, date: '2022-02-15')
        
        valid_credit_attributes = {
          credit_type_id: credit_type_without_carry_forward.id,
          date: '2023-10-11',
          amount: 150,
          description: 'Test Text'
        }

        expect do
          post :create, params: { credit: valid_credit_attributes }
        end.to change(Credit, :count).by(1)

        # Calculate the expected total for the current year (2023)
        expected_total = valid_credit_attributes[:amount]

        # Check the actual total in the database
        actual_total = user.credits.where(credit_type: credit_type_without_carry_forward, date: Date.new(2023, 1, 1)..Date.new(2023, 12, 31)).sum(:amount)
        
        expect(actual_total).to eq(expected_total)
      end
    end
  end

  describe 'Scenario: Creating a New Credit with Invalid Inputs' do
    it 'does not create a new credit with invalid inputs' do
      invalid_credit_attributes = {
        credit_type: 'Credit_type1',
        date: '2023-10-11',
        amount: 10,  # Invalid amount
        description: 'Test credit'
      }

      expect do
        post :create, params: { credit: invalid_credit_attributes }
      end.not_to change(Credit, :count)
    end

    it 'sets an error flash message' do
      invalid_credit_attributes = {
        credit_type: 'Credit_type1',
        date: '2023-10-11',
        amount: 10,  # Invalid amount
        description: 'Test credit'
      }

      post :create, params: { credit: invalid_credit_attributes }
      expect(flash[:error]).to be_present
    end
  end

end

def sign_in_user(user)
    allow(controller).to receive(:current_user).and_return(user)
end