require 'rails_helper'

RSpec.describe PrintsController, type: :controller do
  let(:user) { create(:user) }
  let(:credit_type_without_carry_forward) { create(:credit_type_without_carry_forward) }
# Corrected usage to create a CreditType with carry forward enabled
  let(:credit_type_with_carry_forward) { create(:credit_type_with_carry_forward) }

  describe "GET /show" do
    it "returns http success" do
      sign_in_user(user)
      # add a credit type
      credit_type = create(:credit_type, :name => "CreditType7")
      # add credit type without carry forward
      credit_type_without_carry_forward = create(:credit_type_without_carry_forward)
      # add a credit
      credit = create(:credit, user: user, credit_type: credit_type, :amount => 1)
      # add a credit without carry forward
      credit_without_carry_forward = create(:credit, user: user, credit_type: credit_type_without_carry_forward, :amount => 1)
      get :show
      expect(assigns(:credits)).to eq([credit, credit_without_carry_forward])
      expect(assigns(:credit_totals)).to eq({"CreditType7" => 1, "CreditTypeWithoutCarryForward"=>0})
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:success)
    end
  end

  def sign_in_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

end
