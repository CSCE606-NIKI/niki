class CreditsController < ApplicationController

    before_action :require_login
    def index
        @credits = Credit.all
    end 

    def show
        @credit = Credit.find(params[:id])
    end

    def new
        @credit = Credit.new
        @credit_types = current_user.credit_types.pluck(:name, :id)
    end

    def edit
        @credit = Credit.find(params[:id])
        @credit_types = current_user.credit_types.pluck(:name, :id)
    end

    def update
        @credit = Credit.find(params[:id])
        if @credit.update(credit_params)
          redirect_to @credit, notice: "Credit was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def create
        @credit = Credit.new(credit_params)
        @credit.user = current_user 
        existing_credits = Credit.where(user: current_user, credit_type_id: @credit.credit_type_id)
        credit_type = CreditType.find(@credit.credit_type_id)
        @credit.credit_type = credit_type
        if @credit.credit_type.carry_forward
            # If carry forward is enabled, calculate the cumulative total
            total_number_of_credits = existing_credits.sum(:amount) + @credit.amount
        else
            # If carry forward is not enabled, calculate the total for the current year
            current_year = Time.now.year
            credits_for_current_year = existing_credits.where(date: Date.new(current_year, 1, 1)..Date.new(current_year, 12, 31))
            total_number_of_credits = credits_for_current_year.sum(:amount) + @credit.amount
        end

   
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
            flash[:error] = "You've already reached your credit limit for type #{@credit.credit_type.name}!"
        end
    
    end

    def destroy
        @credit = Credit.find(params[:id])
        @credit.destroy
        redirect_to dashboard_path, notice: "Credit was successfully deleted.", status: :see_other
    end
    
    
    private
    def credit_params
            params.require(:credit).permit(:credit_type, :date , :amount  ,:user_id , :description ,:credit_type_id)
    end
end
