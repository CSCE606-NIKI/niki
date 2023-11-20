class DashboardController < ApplicationController
  before_action :require_login
  def index
    @credits = current_user.credits
    @credits = Credit.where(user: current_user)
    @credits = @credits.order(date: :desc)
    
    @credit_totals = {}
    # get the start and end date set by the user
    end_date = current_user.renewal_date
    start_date = current_user.start_date.to_date

    # Select only credits that are between the start and end date
    @credits = @credits.select { |credit| credit.date >= start_date && credit.date < end_date }

    # Group credits by the credit type
    credits_grouped = @credits.group_by { |credit| credit.credit_type_id }
    # Get the credit type and the credits associated with that credit type and sum them to get the total credits for that type
    credits_grouped.each do |credit_type_id, grouped_credits|
      credit_type = CreditType.find(credit_type_id)
      total_credits = grouped_credits.sum(&:amount)

      @credit_totals[credit_type.name] = total_credits

    end
    @credits = Credit.where(user: current_user).order(date: :desc)
  end
end
 
  