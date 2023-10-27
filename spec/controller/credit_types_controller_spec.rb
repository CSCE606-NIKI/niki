require 'rails_helper'
RSpec.describe CreditTypesController, type: :controller do
    before(:each) do
        @user = FactoryBot.create(:user) # Create a user using FactoryBot
        allow(controller).to receive(:current_user).and_return(@user) # Set current_user in the controller
      end
    describe "GET #new" do
        it "gives a successful response" do 
            get :new
            expect(response).to be_successful
        end
    end

    describe "POST #create" do 
        it "creates a new type successfully" do 
            expect{
                post  :create, params: {credit_type: FactoryBot.attributes_for(:credit_type_without_carry_forward)}}.to change(CreditType, :count).by(1);
            
        end

        it "redirects to dashboard after successful entry " do 
            
            post  :create, params: {credit_type: FactoryBot.attributes_for(:credit_type_without_carry_forward)};
           
             expect(response).to redirect_to(dashboard_path)
        end

        it "does not create a new CreditType" do 
            expect {
                post  :create, params: {credit_type: {name: nil}} 
            }.not_to change(CreditType, :count)
        end 

        it "re-renders the 'new' template" do
            post :create, params: { credit_type: { name: nil } }
            expect(response).to render_template("new")
        end
    end 

end