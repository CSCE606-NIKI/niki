require 'rails_helper'

RSpec.describe "Prints", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/prints/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/prints/show"
      expect(response).to have_http_status(:success)
    end
  end

end
