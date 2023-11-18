# lib/tasks/email_scheduler.rake
namespace :email do
  task :check_renewal_date_to_email => :environment do
    ApplicationController.new.check_renewal_date_to_email
  end
end
