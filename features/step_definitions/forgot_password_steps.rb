
When('I click on the "Forgot Password" link') do
click_link "Forgot Password" # Replace with the actual text or selector for the link
end

Then('I should see a password reset form') do
expect(page).to have_content("Password Reset Form") # Replace with the expected content on the reset form
end

When('I enter my email {string}') do |email|
fill_in "Email", with: email # Replace "Email" with the actual field name for email
end

When('I click the "Reset" button') do
click_button "Reset" # Replace "Reset" with the actual text or selector for the button
end

Then('I should receive a password reset email') do
# Implement code to check if a password reset email has been sent to the user
# You may need to use email testing libraries or interact with your email service
# This step definition will depend on how you handle email sending in your application
end

When('I enter an invalid email {string}') do |email|
fill_in "Email", with: email # Replace "Email" with the actual field name for email
end

Then('I should see an error message') do
expect(page).to have_content("Invalid email") # Replace with the expected error message content
end
  
