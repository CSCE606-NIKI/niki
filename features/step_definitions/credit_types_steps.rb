Given('I have created a credit type {string}') do |credit_type_name|
    @user = User.find_by(email: "user@example.com")  # Adjust this based on your setup
    @credit_type = @user.credit_types.create(name: credit_type_name, credit_limit: 20, carry_forward: true)
end

When("I visit the new credit type page") do
   visit new_credit_type_path
end


When("I check {string}") do |field|
   check field
end

When("I uncheck {string}") do |field|
   uncheck field
end

When("I press {string}") do |button|
   click_on button
end

Given("I have added a credit type") do
   @credit_type = @user.credit_types.create(name: "Type", credit_limit: 100, carry_forward: true)
   raise "Credit type not created successfully" unless @user.credit_types.count > 0
end

When("I should see the {string} link for the new credit type") do|string|
   expect(page).to have_link("Show this Credit Type", href: "/credit_types/Type")
end

When(/^I click link "Show this Credit Type"$/) do
    puts @credit_totals.inspect
    click_link("Show this Credit Type")
end

When("I click {string}") do |button|
    click_link(button)
end

Then('I should see Edit button') do
    expect(page).to have_button('Edit')
end

When("I click on Edit button") do
    click_button "Edit"
end

Then("I should be directed to edit_credit_type_path") do
    @credit_type = CreditType.find_by(name: 'Type')
    visit edit_credit_type_path(@credit_type)
end

And("click Update Credit type") do
    puts "Current Path: #{current_path}"
    click_button "Update Credit type"
end

Then("I should be redirected to Dashboard") do
    expect(current_path).to eq(dashboard_path)
end

Then('should see a message') do
    expect(page).to have_content('Credit type updated successfully.')
end
# delete .......
Then('I should see Delete button') do
    expect(page).to have_button('Delete')
end

When('I click on Delete button') do
    click_button "Delete"
end

Then('should see a deletion message') do
    expect(page).to have_content('Credit type was successfully deleted.')
end
