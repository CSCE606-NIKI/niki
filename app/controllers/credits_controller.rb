class CreditsController < ApplicationController

    before_action :require_login
    def index
    end 

    def new
        @credit = Credit.new
        @credit_types = CreditType.pluck(:name, :id) # Fetches credit type names and IDs
    end

    def create
        @credit = Credit.new(credit_params)
        @credit.user = current_user 
        existing_credits = Credit.where(user: current_user, credit_type_id: @credit.credit_type_id)
        total_number_of_credits = existing_credits.sum(:amount) + @credit.amount
        credit_type = CreditType.find(@credit.credit_type_id)
        @credit.credit_type = credit_type
        if total_number_of_credits <= credit_type.credit_limit
            @credit.total_number_of_credits = total_number_of_credits
            if @credit.save
                flash[:notice] = "Added Successfully!"
                redirect_to dashboard_path
                return 
            else
                redirect_to new_credit_path
                flash[:error] = "Couldn't be added, try again!"
            end
        else
            redirect_to new_credit_path
            flash[:error] = "You've already reached your credit limit for type #{@credit.credit_type}!"
        end
        
    end
    
    private
    def credit_params
            params.require(:credit).permit(:credit_type, :date , :amount  ,:user_id , :description ,:credit_type_id)
    end
end
