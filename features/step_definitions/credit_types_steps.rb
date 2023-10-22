# credit_types_steps.rb
Given('I have created a credit type {string}') do |string|
    @credit_type = CreditType.create(name:'type1', credit_limit: 1000);
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

