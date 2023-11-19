# lib/tasks/email_scheduler.rake
namespace :email do
  task :check_renewal_date_to_email => :environment do
    User.all.each do |user|
      renewal_date = user.renewal_date
      start_date = renewal_date - 1.year
      end_date = renewal_date
      credit_data = Credit.where(user_id: user.id)
      sum_of_credits = credit_data.where(date: start_date..end_date).sum(:amount)
      unique_credit_types = credit_data.map { |credit| credit.credit_type }.uniq
      total_credit_limit = unique_credit_types.sum { |credit_type| credit_type.credit_limit }
      #check_and_send_pending_credits_email(user, all_credits)
      puts "Creditsssss ", sum_of_credits, unique_credit_types, total_credit_limit
    end
  end
end

def check_and_send_pending_credits_email(user, all_credits)
  puts "*********HEREEeeeeeeeeeee**********"
  user_renewal_date = user.renewal_date
  puts "User name: ", user.username
  puts "renewal_date: ", user.renewal_date

  # Calculate the difference in days between user_renewal_date and current_date
  days_difference = (user_renewal_date - Date.current).to_i

  # Determine the frequency based on the days difference
  case days_difference
  when 90, 60, 45, 30, 23, 16,12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
    puts "Sending email to: ", user.email, days_difference
    CreditMailer.send_pending_credits_email(user, all_credits).deliver_now
  end
end