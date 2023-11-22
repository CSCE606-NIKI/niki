require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) } 
  describe 'PUT #set_renewal_date' do
    it 'redirects to dashboard after setting new renewal date' do
        cookies[:auth_token] = user.auth_token
        put :set_renewal_date, params: {user: { renewal_date: Date.today + 1 }, id: user.id}
        expect(response).to redirect_to(dashboard_path) 
        end
  end
end