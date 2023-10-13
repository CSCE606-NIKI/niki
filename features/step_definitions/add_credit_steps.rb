
Given('I am logged in as {string} with password {string}') do |string, string2|
    @user = User.create(username:'user1', email: string, password: string2)
    visit login_path
    fill_in("Email or Username", :with => @user.email)
    fill_in("password", :with => @user.password)
    click_button("Log in")
end

When("I visit the dashboard page") do
    visit dashboard_path
end

Then("I should see the {string} page title") do |page_title|
    expect(page).to have_content(page_title)
end

And("I should see the {string} link") do |button_text|
    expect(page).to have_content(button_text)
end

When("I visit the new credit page") do
    visit new_credit_path
    expect(page).to have_content("Add Credit")
end

And("I fill in the following:") do |table|
    within '#credit-form' do
        table.hashes.each do |row|
        case row['Field']
        when 'Credit Type'
            select row['Value'], from: 'credit_credit_type'
        when 'Date'
            fill_in 'credit_date', with: row['Value']
        when 'Amount'
            fill_in 'credit_amount', with: row['Value']
        when 'Description'
            fill_in 'credit_description', with: row['Value']
        end
        end
    end
end 

Then("I should be redirected to the dashboard") do
    expect(current_path).to eq(dashboard_path)
end

And("I should see a success message") do
    expect(page).to have_content("Credit created successfully")
end

And("a new credit with type {string} and amount {string} should exist in the system") do |credit_type, amount|
    expect(Credit.exists?(credit_type: credit_type, amount: amount)).to be true
end

Given("I have existing credits of type {string} totaling to {string}") do |credit_type, total_amount|
    expect(Credit.exists?(credit_type: credit_type, amount: total_amount)).to be true
end

Then('I should see an error message for {string}') do |string|
    expect(page).to have_content(string)
end

And("I should not be redirected to the dashboard") do
    expect(current_path).to_not eq(dashboard_path)
end

And("a new credit with type {string} and amount {string} should not exist in the system") do |credit_type, amount|
    expect(Credit.exists?(credit_type: credit_type, amount: amount)).to be false
end

Given("there is a credit with type {string} in the system") do |credit_type|
# Create a credit in the system with the specified type
end

When("I visit the credit page for that credit") do
    visit(new_credit_path)
end

Then("I should see the credit details") do
# Implement logic to check if the credit details are displayed on the page
end