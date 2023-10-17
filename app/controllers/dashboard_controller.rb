class DashboardController < ApplicationController
  before_action :require_login
  def index
    @credits = current_user.credits
    @credits = @credits.order(date: :desc)
    @credit_totals = {}

    @credits.each do |credit|
      # credit_type = credit.credit_type
      total_credits = current_user.credits.where(credit_type_id: credit.credit_type_id).sum(:amount)
      credit_type = CreditType.find(credit.credit_type_id)
      @credit_totals[credit_type.name] = total_credits
      puts @credit_totals
    end

  end

 
end
  