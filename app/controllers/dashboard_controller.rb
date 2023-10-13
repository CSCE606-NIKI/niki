class DashboardController < ApplicationController
  before_action :require_login
  def index
    @credits = current_user.credits # Assuming you have a relationship set up in your User model
    @credits = @credits.order(date: :desc)   
    @credit_totals = {}

    Credit::CREDIT_TYPES.each do |credit_type|
      total_credits = current_user.credits.where(credit_type: credit_type).sum(:amount)
      @credit_totals[credit_type] = total_credits
    end
  end

 
end
  