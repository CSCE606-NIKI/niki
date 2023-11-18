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

  # Check if user_renewal_date is exactly 3 months away from current_date
  if user_renewal_date <= 3.months.from_now
    puts "Sending email to: ", user.email
    CreditMailer.send_pending_credits_email(user).deliver_now
    # Call your method to send the email here
  end
end

