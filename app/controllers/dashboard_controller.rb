class DashboardController < ApplicationController
  def index
    @credit_totals = {}

    Credit::CREDIT_TYPES.each do |credit_type|
      total_credits = Credit.where(credit_type: credit_type).sum(:amount)
      @credit_totals[credit_type] = total_credits
    end
  end
end
  