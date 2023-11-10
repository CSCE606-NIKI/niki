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
        @credit.total_number_of_credits = total_number_of_credits
        if @credit.save
            flash[:notice] = "Added Successfully!"

            if total_number_of_credits > credit_type.credit_limit
                flash[:error] = "You've already reached your credit limit for type #{@credit.credit_type.name}!"
            end
            redirect_to dashboard_path
 
        else
            redirect_to new_credit_path
            flash[:error] = "Couldn't be added, try again!"
        end
    end
    
    def renew
      user_renewal_date = current_user.renewal_date
      current_date = Date.today
    
      if request.post?
        total_carry_forward_amount = 0
        carry_forward_errors = false  # Track if there are carry forward errors
    
        current_user.credits.each do |credit|
          if credit.credit_type.carry_forward
            carry_forward_amount = params["credit_#{credit.id}_carry_forward_amount"].to_i
            excess_credits = [credit.amount - credit.credit_type.credit_limit, 0].max
    
            if carry_forward_amount <= excess_credits
              total_carry_forward_amount += carry_forward_amount
              credit.amount = carry_forward_amount
              credit.date = current_date
              credit.save
              flash[:notice] = "#{credit.credit_type.name} renewal completed successfully."
            else
              carry_forward_errors = true  # Set the carry forward error flag
              flash[:error] = "Please fill in credit values that are within your excess credits for #{credit.credit_type.name}"
            end
          else
            credit.amount = 0
            credit.date = current_date
            credit.save
          end     
        end
    
        if !carry_forward_errors && total_carry_forward_amount <= 14
          flash[:notice] = "Credit renewal completed successfully."
          redirect_to dashboard_path
        else
          # Handle the case when there are carry forward errors or total exceeds 14
          # Render the renewal form again to adjust choices
          render :renew
        end
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
