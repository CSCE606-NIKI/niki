namespace :email do
  task :check_renewal_date_to_email => :environment do
    User.all.each do |user|
      renewal_date = user.renewal_date
      start_date = user.start_date.to_date
      end_date = renewal_date
      credit_data = Credit.where(user_id: user.id)
      sum_of_credits = credit_data.where(date: start_date..end_date).sum(:amount)
      unique_credit_types = credit_data.map { |credit| credit.credit_type }.uniq
      total_credit_limit = unique_credit_types.sum { |credit_type| credit_type.credit_limit }
      pending_credits = total_credit_limit - sum_of_credits
      if pending_credits > 0 # or any other condition that makes sense for your application
        puts "Creditsssss ", sum_of_credits, unique_credit_types, total_credit_limit
        credit_progress = {} 
        unique_credit_types.each do |credit_type|
          @fil_credits = credit_data.where(credit_type: credit_type, date: start_date..end_date)
          sum_of_credits = @fil_credits&.sum(&:amount) || 0
          credit_progress[credit_type.name] = {
            sum_of_credits: sum_of_credits,
            total_credit_limit: credit_type.credit_limit
          }
        end
        check_and_send_pending_credits_email(user, credit_progress, pending_credits)
      end
    end
  end
end

def check_and_send_pending_credits_email(user, credit_progress, pending_credits)
  user_renewal_date = user.renewal_date
  puts "User name: ", user.username
  puts "renewal_date: ", user.renewal_date

  # Calculate the difference in days between user_renewal_date and current_date
  days_difference = (user_renewal_date - Date.current).to_i

  # Determine the frequency based on the days difference
  case days_difference
  when 90, 60, 45, 30, 23, 16,12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
    puts "Sending email to: ", user.email, days_difference
    CreditMailer.send_pending_credits_email(user, credit_progress, pending_credits).deliver_now
  end
end