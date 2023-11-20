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

    describe "GET #edit" do
        it "gives a successful response" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            get :edit, params: { id: credit_type.id }
            expect(response).to be_successful
        end
    end

    describe "PATCH #update" do
        it "updates the credit type successfully" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            patch :update, params: { id: credit_type.id, credit_type: { name: "New Name" } }
            credit_type.reload
            expect(credit_type.name).to eq("New Name")
        end

        it "redirects to dashboard after successful update" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            patch :update, params: { id: credit_type.id, credit_type: { name: "Updated Name" } }
            expect(response).to redirect_to(dashboard_path)
        end

        it "does not update the credit type with invalid data" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            patch :update, params: { id: credit_type.id, credit_type: { name: nil } }
            credit_type.reload
            expect(credit_type.name).not_to be_nil
        end

        it "re-renders the 'edit' template with invalid data" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            patch :update, params: { id: credit_type.id, credit_type: { name: nil } }
            expect(response).to render_template("edit")
        end
    end

    describe "DELETE #destroy" do
        it "deletes the credit type successfully" do
            credit_type = FactoryBot.create(:credit_type, user: @user)
            expect {
                delete :destroy, params: { id: credit_type.id }
            }.to change(CreditType, :count).by(-1)
        end

    end
end