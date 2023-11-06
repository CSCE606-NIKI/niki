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

When("I visit the Add New credit page") do
    visit new_credit_path
    expect(page).to have_content("Add New credit")
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

Given('I am on Add New credit page') do
    visit(new_credit_path)
end

When("I click the {string} link for the first credit") do |link_text|
    first('a', text: link_text).click
end

Then('I should be redirected to show this credit path') do
    credit = Credit.find_by(credit_type: 'Credit_type1')
    expect(credit).not_to be_nil

    visit credit_path(credit)
end

Then('I should see the credit details on the page') do
    expect(page).to have_content("Type:")
end

When('I click on "Edit credit" button') do
    click_link("Edit credit")
end

Then('I should be redirected to edit credit page') do
    credit = Credit.find_by(credit_type: 'Credit_type1')
    visit edit_credit_path(credit)
end

When("I click the {string} link button") do |string|
    click_link(string)
end

When("I click on the button {string} to delete") do |string|
    click_button(string)
end

Then('this credit shouldnot be there') do
    credit = Credit.find_by(credit_type: 'Credit_type1')
    expect(Credit.exists?(credit)).to be false
end

Then('I should see an message {string}') do |string|
    expect(page).to have_content(string)
  end
  When("I visit the renew credits page") do
    visit renew_path
  end
  
  When("I select valid carry-forward amounts") do
    # Iterate through credits with carry_forward and select valid carry-forward amounts
    # Fill in form fields using fill_in method
    @credit_type = CreditType.find_by(name: 'renew_credits')

    @credit = Credit.find_by(credit_type_id: @credit_type.id)

    if @credit_type.carry_forward
    fill_in "credit_#{@credit.id}_carry_forward_amount", with: [@credit.amount - @credit_type.credit_limit,14].min  # Choose a valid amount
    end
  end
  
  When("I submit the renewal form") do
    click_button "Renew Credits"
  end
  
  Then("I should see a success message for credits renewal") do
    expect(page).to have_content("Credit renewal completed successfully.")
  end
  
  When("I select invalid carry-forward amounts") do
    @credit_type = CreditType.find_by(name: 'renew_credits')
    @credit = Credit.find_by(credit_type_id: @credit_type.id)
    if @credit_type.carry_forward
    fill_in "credit_#{@credit.id}_carry_forward_amount", with: @credit.amount - @credit_type.credit_limit+5  # Choose a valid amount
    end
  end

  Then("I should see an error message for credits renewal") do
    @credit_type = CreditType.find_by(name: 'renew_credits')
    @credit = Credit.find_by(credit_type_id: @credit_type.id)
    expect(page).to have_content("Please fill in credit values that are within your excess credits for #{@credit_type.name}")
  end
 
  