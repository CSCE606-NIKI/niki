class CreditsController < ApplicationController

    before_action :require_login
    def index 
    end 

    def new
        @credit = Credit.new
        @credit_types = ['Credit_type1', 'Credit_type2', 'Credit_type3']
    end

    def create

        @credit = Credit.new(credit_params)
        @credit.user = current_user 

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
            flash[:error] = "You've already reached your credit limit for type #{@credit.credit_type}!"
            render 'new'
        end
    end

    def show
        @credit = Credit.find_by(params[:id])
    end

    def update
        @credit = Credit.new
        #@credit.user = current_user 
        puts current_user
        @credit.user = current_user
        @credit_type = "Type1"
        puts "###########", @credit_type
        render 'edit'
        # existing_credits = Credit.where(credit_type: @credit.credit_type)
        
        # if @credit.amount <= Credit::CREDIT_LIMITS[@credit.credit_type]
        #     if !existing_credits.update(amount: @credit.amount)
        #         render 'new'
        #     end
        #     total_credits = existing_credits.sum(:amount) + @credit.amount
        #     if !existing_credits.update(total_number_of_credits: total_credits)
        #         render 'new'
        #     end
        #     if !existing_credits.update(description: @credit.description)
        #         render 'new'
        #     end
        #     if existing_credits.update(updated_at: Time.now)
        #         redirect_to dashboard_path
        #     else
        #         render 'new'
        #     end
        # else
        #     flash[:error] = "You can't update to a credit higher than your credit limit #{@credit.credit_type}!"
        #     render 'new'
        # end

    end

    def edit
        puts "in edit page"
        @credit = Credit.new
        @credit.user = current_user
        puts "$$$$$$$$$$$$$$$$$", current_credit
        selected_credit_type = credit_edit_params[:credit_type]
        puts "+++++",selected_credit_type
        credit_edit_params[:credit_type] = @credit_type
        @credit.update(credit_edit_params)
        redirect_to dashboard_path


    end
    private
    def credit_edit_params
            params.require(:credit).permit(:credit_type, :date , :amount  ,:user_id , :description)
    end

    private
    def credit_params
            params.require(:credit).permit(:credit_type, :date , :amount  ,:user_id , :description)
    end

end
