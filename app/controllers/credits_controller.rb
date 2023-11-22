class CreditsController < ApplicationController

    before_action :require_login

    before_action :check_renewal_date, only: [:renew]

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
    
        ActiveRecord::Base.transaction do
          # Rollback all changes made before the renewal process
          current_user.credits.reload
    
          credits_by_type = current_user.credits.group_by { |credit| credit.credit_type }
    
          credits_by_type.each do |credit_type, credits|
            if credit_type.carry_forward
              carry_forward_amount = params["credit_#{credits.first.id}_carry_forward_amount"].to_i
              total_credits = credits.sum { |credit| credit.amount }
              excess_credits = [total_credits - credit_type.credit_limit, 0].max
    
              if carry_forward_amount <= excess_credits
                new_credit_total = carry_forward_amount
    
                new_credit = Credit.new(
                  user: current_user,
                  credit_type: credit_type,
                  amount: new_credit_total,
                  date: current_date,
                  total_number_of_credits: 0,
                )
    
                total_carry_forward_amount += carry_forward_amount
                new_credit.save
                unless new_credit.save
                  puts new_credit.errors.full_messages
                end
              else
                carry_forward_errors = true
                flash[:error] = "Please fill in credit values that are within your excess credits for #{credit_type.name}"
                raise ActiveRecord::Rollback
              end
            else
              new_credit = Credit.new(
                user: current_user,
                credit_type: credit_type,
                amount: 0,
                date: current_date,
                total_number_of_credits: 0,
              )
              new_credit.save
              unless new_credit.save
                puts new_credit.errors.full_messages
              end
            end
          end
    
          if !carry_forward_errors && total_carry_forward_amount <= 14
            flash[:notice] = "Credit renewal completed successfully."
            redirect_to renewal_date_user_path(current_user)
          else
            flash[:error] ||= "Credit renewal failed. Please check the error messages."
            # Rollback the changes made during the renewal process
            raise ActiveRecord::Rollback
            redirect_to renew_credits_path
          end
        end
      end
    end
    
    def visualize
        render :visualize
    end

    def destroy
        @credit = Credit.find(params[:id])
        @credit.destroy
        redirect_to dashboard_path, notice: "Credit was successfully deleted.", status: :see_other
    end
    
    def check_renewal_date
      user_renewal_date = current_user.renewal_date
  
      if user_renewal_date && user_renewal_date > Date.today
        flash[:error] = "Renewal is not yet available. Please check back after the current renewal date."
        redirect_to dashboard_path # Replace with the path you want to redirect to
      end
    end

    private
    def credit_params
            params.require(:credit).permit(:credit_type, :date , :amount  ,:user_id , :description ,:credit_type_id)
    end
end
