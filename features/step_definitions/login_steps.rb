Given('I am a registered user and I am on the login page') do
    @mock_user = create(:user,username: 'mockuser', email: 'mock@gmail.com' , password: 'password') 
    visit login_path 
end

Given('I am on the login page') do
    visit login_path 
end
  

Given('I am new user and I am on the user new page') do
    visit new_user_path 
end

When('I fill in {string} with {string}') do |string, string2|
    fill_in string, with: string2
end

When('I click on {string}') do |string|
    click_button string
end

Then('I should see {string}') do |content|
    expect(page).to have_content(content)
end
