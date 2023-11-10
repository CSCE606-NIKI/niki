require 'rails_helper'

RSpec.describe "Prints", type: :request do
    let(:user) { create(:user) } 

  describe "GET /show" do
    it "returns HTTP 200 if PDF is successfully generated" do
      cookies[:auth_token] = user.auth_token
      get "/print"
      expect(response).to have_http_status(200)
    end
    it "redirects to login if user is not logged in" do
        get "/print"
        expect(response).to redirect_to(login_path)
    end
  end

end
