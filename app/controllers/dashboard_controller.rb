class DashboardController < ApplicationController
  before_action :require_login
  def index
    @credits = Credit.all
    @credit_totals = {}

    Credit::CREDIT_TYPES.each do |credit_type|
      total_credits = current_user.credits.where(credit_type: credit_type).sum(:amount)
      @credit_totals[credit_type] = total_credits
    end
  end

 
end
  