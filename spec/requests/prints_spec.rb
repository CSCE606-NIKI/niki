require 'rails_helper'

RSpec.describe "Prints", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/prints/show"
      expect(response).to have_http_status(:redirect)
    end
  end

end
