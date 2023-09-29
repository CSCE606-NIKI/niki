<<<<<<< HEAD
Given('I am on the login form') do
    visit login_path
end  
=======
>>>>>>> 736ff2640835926c9f18d93917284a17a0cf1f6c

When('I click on the "Forgot Password?" link') do
    click_link "Forgot Password?"
end

Then('I should see a password reset form') do
    expect(page).to have_selector('.passwordreset')
end


Given('I am on the password reset page') do
    visit password_reset_path
end
  

When('I enter my email {string}') do |email|
    fill_in 'Email', with: email
end
  

When('I click the "Reset Password" button') do
    click_button 'Reset Password'
end

Then('I should receive a password reset email') do
    
    mail_logs = File.read('log/mail.log')
  
    # Define a regular expression to match the success log entry
    success_log_pattern = /PasswordMailer#reset: processed outbound mail in \d+\.\d+ms/
  
    # Use regular expression matching to find the success log entry
    expect(mail_logs).to match(success_log_pattern)
end
  
When('I enter an invalid email {string}') do |email|
    fill_in "Email", with: email
end

Then('I should see an error message displaying {string}') do |error_message|
    expect(page).to have_selector('.passwordreset-alert', text: error_message)
end

Then('I should see a password reset page') do
    expect(page).to have_content('password_reset_path')
end
  

Then('I should be able to enter a new password') do
    fill_in 'New Password', with: 'new_password'
    fill_in 'Confirm Password', with: 'new_password'
    click_button 'Reset' 
end

Then('I should see a success message') do
    expect(page).to have_content('Password reset successful.')
end

Given('I have received a password reset email') do
    # Implement code here to check the mail log for a password reset email
    mail_logs = File.read('log/mail.log')
  
    # Define a regular expression to match the success log entry
    success_log_pattern = /PasswordMailer#reset: processed outbound mail in \d+\.\d+ms/
  
    # Use regular expression matching to find the success log entry
    expect(mail_logs).to match(success_log_pattern)
end
  
When('I click on the reset password link in the email') do
    # Implement code here to visit the reset password link in the email
    # This might involve extracting the link from the mail log or using a testing library
    mail_logs = File.read('log/mail.log')
  
    # Define a regular expression to match the password reset link
    link_pattern = /Reset Password Link: (.+)/
  
    # Extract the password reset link from the mail log
    reset_password_link = mail_logs.match(link_pattern)&.captures&.first
  
    # Visit the reset password link
    visit reset_password_link
end

   

  