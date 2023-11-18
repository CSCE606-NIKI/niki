set :output, "log/cron.log"

every '* * * * *' do
  command "bundle exec rake email:check_renewal_date_to_email"
  command "echo 'Scheduler ran at: $(date)'"
end