class CreditsController < ApplicationController
    def index 
    end 

    def new
        @credit = Credit.new
        @credit_types = ['Credit_type1','Credit_type2', 'Credit_type3']
    end

    def create

        @credit = Credit.new(credit_params)
        existing_credits = Credit.where(credit_type: @credit.credit_type)
        total_number_of_credits = existing_credits.sum(:amount) + @credit.amount
        if total_number_of_credits <= Credit::CREDIT_LIMITS[@credit.credit_type]
            @credit.total_number_of_credits = total_number_of_credits
            if @credit.save
              redirect_to dashboard_path
            else
              render 'new'
            end
        else
        flash[:error] = "You've already reached your credit limit for type #{@credit[:credit_type]}!"
        render 'new'
        end
    end

    def show
        @credit = Credit.find_by(params[:id])
    end

    private
    def credit_params
            params.require(:credit).permit(:credit_type, :date , :total_number_of_credits , :amount)
    end
end