require 'rails_helper'

RSpec.describe "CreditTypes", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:current_user).and_return(@user)
  end

end
