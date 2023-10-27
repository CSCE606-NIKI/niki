# features/step_definitions/credits_steps.rb

Given("I am on dashboard") do
  visit "/dashboard"
end

When("I have {int} credits due soon") do |credits_count|
  @credits = [] # You can initialize @credits as needed for testing
  credits_count.times do |i|
    @credits << OpenStruct.new(description: "Credit #{i + 1} description")
  end
end

Then("I should see a button with the text {string}") do |button_text|
  button = find('.credits-notification-container .btn-secondary')
  expect(button).to have_text(button_text)
end

And("I click the bell icon") do
  button = find('.bell-icon')
  button.click
end

And("I click the button") do
  button = find('.credits-notification-container .btn-secondary')
  button.click
end

Then("I should see a dropdown menu") do
  dropdown_menu = find('.credits-notification-container .dropdown-menu')
  expect(dropdown_menu).to be_visible
end

And("I should see {int} credit descriptions") do |expected_count|
  credit_descriptions = all('.credits-notification-container .dropdown-item')
  expect(credit_descriptions.count).to eq(expected_count)
end

Then("I should not see the button") do
  expect(page).not_to have_css('.credits-notification-container .btn-secondary')
end

And("I should not see a dropdown menu") do
  expect(page).not_to have_css('.credits-notification-container .dropdown-menu')
end

When("I have no credits due soon") do
  # Assuming @credits is the variable that holds the list of credits
  @credits = [] # Set @credits to an empty array
end
