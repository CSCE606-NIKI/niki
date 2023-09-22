
require 'capybara'
require 'database_cleaner'
require 'capybara/dsl'

Given(/^I go to the URL "(.*?)"$/) do |url|
  Capybara.current_session.visit(url)
end

Then(/^the page should have "(.*?)"$/) do |expected_text|
  expect(page).to have_content(expected_text)
end

When('I fill in the following information') do |table|
  data = table.hashes.first
  fill_in 'Email', with: data['Email']
  fill_in 'Password', with: data['Password']
  fill_in 'Password confirmation', with: data['Password confirmation']
end

Then('I should see an error message') do
end

Then('I should see a missing field error') do
end

When('I click the {string} button') do |button_text|
  click_button(button_text)
end

Then('I should be logged in') do
  expect(page).to have_content('Welcome')
end



