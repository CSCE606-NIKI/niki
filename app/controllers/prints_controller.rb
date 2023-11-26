class PrintsController < ApplicationController
  before_action :require_login
  def show
    @user = current_user
    @credits = @user.credits
    @credits = Credit.where(user: current_user)
    @credits = @credits.order(date: :desc)
    @credit_totals = {}
    current_year = Time.now.year

    credits_grouped = @credits.group_by { |credit| credit.credit_type_id }
    credits_grouped.each do |credit_type_id, grouped_credits|
      credit_type = CreditType.find(credit_type_id)

      if credit_type.carry_forward
        # If carry forward is enabled, calculate the cumulative total
        total_credits = grouped_credits.sum(&:amount)
      else
        # If carry forward is not enabled, filter and calculate the total for the current year
        credits_for_current_year = grouped_credits.select { |credit| credit.date.year == current_year }
        total_credits = credits_for_current_year.sum(&:amount)

        # If it's the start of a new year, reset the total to 0
        if Time.now.month == 1 && Time.now.day == 1
          total_credits = 0
        end
      end
      @credit_totals[credit_type.name] = total_credits

    end

    @html = render_to_string "show", layout: "pdf"
    pdf = Grover.new(@html, format: 'letter').to_pdf
    send_data(pdf, filename: "CreditsSummary.pdf", type: 'application/pdf')
  end

end