
Given('I am on the login form') do
    visit login_path
end  

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
  
When('I click "Reset Password" button') do
    click_button 'Reset Password'
end
  
When('I enter an invalid email {string}') do |email|
    fill_in "Email", with: email
end

Then('I should see a message displaying {string}') do |error_message|
    expect(page).to have_selector('.passwordreset-alert', text: error_message)
end

Given('a user with email {string} exists') do |email|
    FactoryBot.create(:user, email: email)
end

When('I request a password reset for {string}') do |email|
    @user = User.find_by(email: email)
    @token = @user.signed_id(purpose: 'password_reset', expires_in: 30.minutes)
    visit password_resets_edit_path(token: @token)
end

Then('I should see a password reset page') do
    expect(page).to have_content('Password Reset')
end 

Then('I should be able to enter a new password') do
    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_button 'Reset Password' 
end

Then('I should see a success message') do
    expect(page).to have_content('Your password was reset succesfully. Please log in.')
end
