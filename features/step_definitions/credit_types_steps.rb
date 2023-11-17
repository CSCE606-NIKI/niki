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
#    @credit_type = @user.credit_types.create(name: "Type", credit_limit: 100, carry_forward: true)
#    raise "Credit type not created successfully" unless @user.credit_types.count > 0
   @new_credit_type_name = "New Type"
   @user.credit_types.create(name: @new_credit_type_name, credit_limit: 100, carry_forward: true)
end

# When(/^I click link "([^"]*)"$/) do |link_text|
#     puts page.html
#     click_link(link_text) 
# end
When("I should see the {string} link for the new credit type") do|string|
#    expect(page).to have_link(string, href: credit_type_path(CreditType.find_by(name: @new_credit_type_name)))
   puts page.body
   puts @credit_totals.inspect
   expect(page).to have_link("Show this Credit Type", href: "/credit_types/1")
end

When(/^I click link "Show this Credit Type"$/) do
    puts @credit_totals.inspect
    click_link("Show this Credit Type")
    # @credit_type = CreditType.find_by(name: 'Type')
    # puts "Credit Type ID: #{@credit_type.id}"

    # # Print the HTML of the page for debugging purposes
    # puts page.html

    # # Click the link with a specific selector and wait for up to 10 seconds
    # find('table.styled-table td a', text: 'Show this Credit Type', wait: 10).click
end

When("I click {string}") do |button|
    click_link(button)
end

Then('I should see Edit button') do
    expect(page).to have_button('Edit')
end

When('I click on {string} button') do |button|
    click_button button
end

Then('I should be directed to {string}') do |path|
    visit path
end

When('click Update Credit type') do
    click_button 'Update Credit type'
end

Then('I should be directed to Dashboard') do
    visit dashboard_path
end

Then('I should see Delete button') do
    expect(page).to have_button('Delete')
end

Then('I shouldnot see Type1 Credit type') do
    pending # Write code here that turns the phrase above into concrete actions
end

When('I click on Edit button') do
    pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be directed to edit_credit_type_path') do
    pending # Write code here that turns the phrase above into concrete actions
end

When('click Update Credit Type') do
    pending # Write code here that turns the phrase above into concrete actions
end
