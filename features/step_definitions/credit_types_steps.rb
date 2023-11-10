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

