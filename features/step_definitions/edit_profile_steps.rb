# features/step_definitions/edit_profile_steps.rb

Given('I am a registered user and I am on the login page') do
    @mock_user = create(:user,username: 'mockuser', email: 'mock@gmail.com' , password: 'password') 
    visit login_path 
end

Given('I am on the login page') do
    visit login_path 
end

When("I visit the edit profile page") do
  visit profile_edit_path(@current_user)
end

When("I attach the file {string} to {string}") do |file, field|
  puts File.join(Rails.root, file)
  attach_file(field, File.join(Rails.root, file))
end


When("I update my profile with the following information:") do |table|
  data = table.hashes.first
  fill_in "Name", with: data['Name']  # Change "Name" to match the label in your form
  fill_in "Email", with: data['Email']
  click_on "Update Profile"
end
