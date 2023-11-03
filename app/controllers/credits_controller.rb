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
        all_credits = Credit.where(user: @credit.user,credit_type_id: @credit.credit_type_id)
        credit_type = @credit.credit_type  
        total_number_of_credits = all_credits.sum(&:amount)
        puts total_number_of_credits
    
        @credit.total_number_of_credits = total_number_of_credits
        if @credit.save
            flash[:notice] = "Added Successfully!"
            redirect_to dashboard_path

            if total_number_of_credits > credit_type.credit_limit
                flash[:error] = "You've already reached your credit limit for type #{@credit.credit_type.name}!"
            end
            return 
        else
            redirect_to new_credit_path
            flash[:error] = "Couldn't be added, try again!"
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
