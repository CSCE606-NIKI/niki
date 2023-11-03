class CarryForwardJob
  include Sidekiq::Job

  def perform(*args)
    credit_type = CreditType.find_by(carry_forward: true)

    if credit_type
      credits_to_carry_forward = Credit
        .where(date: (Time.now.beginning_of_year..Time.now.end_of_year))
        .joins(:credit_type)
        .where('carry_forward = ?', true)
        .where('amount >= credit_limit')
      # Calculate the total amount of credits to carry forward
      total_carry_forward_amount = credits_to_carry_forward.sum(:amount)

      # Check if there are credits to carry forward
      if total_carry_forward_amount > 0
        # Calculate the carry-over year
        carry_over_year = Time.now.year + 1

        # Set the carry-over date to January 1 of the next year
        carry_over_date = Date.new(carry_over_year, 1, 1)

        # Calculate the amount to be carried over
        carry_over_amount = [total_carry_forward_amount, 14].min
        # Distribute the carry-over amount among the eligible credits
        credits_to_carry_forward.each do |credit|
          credit_type = credit.credit_type
          if carry_over_amount <= 0
            puts "Update credits to have 0 amount "
            credit.update(date: carry_over_date, amount: 0)
            next 
          else
            excess_credits = [credit.amount - credit_type.credit_limit, 0].max
            if excess_credits <= carry_over_amount
              # Carry over the full excess amount for this credit
              puts "Carry over the full excess amount for this credit"
              credit.update(date: carry_over_date, amount: excess_credits)
              carry_over_amount -= excess_credits
            else
              # Partial carry-over for this credit
              puts "Partial carry-over for this credit"
              credit.update(date: carry_over_date, amount: 14)
              carry_over_amount -= 14
            end
          end
        end
      end
    credit_type = CreditType.find_by(carry_forward: false)

    Credit
      .where(date: (Time.now.beginning_of_year..Time.now.end_of_year))
      .joins(:credit_type)
      .where('carry_forward = ?', false).update_all(amount: 0)
    end
  end
end
