# lib/tasks/email_scheduler.rake
namespace :email do
  task :check_renewal_date_to_email => :environment do
    User.all.each do |user|
      check_and_send_pending_credits_email(user)
    end
  end
end

def check_and_send_pending_credits_email(user)
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
    CreditMailer.send_pending_credits_email(user).deliver_now
  end
end