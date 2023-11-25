# features/step_definitions/credit_mailer_steps.rb
Given('a user with username {string} and email {string} and password {string} and renewal date {string}') do |username, email, password, renewal_date|
  @user = User.create(username: username, email: email, password: password, renewal_date: renewal_date, start_date: Date.new(2020,1,1));
  @user.save! 
end

Given('the user has pending credits for credit type {string}') do |credit_type_name|
  credit_type = CreditType.create!(name: credit_type_name, credit_limit: 20, carry_forward: true)
  Credit.create!(user: @user, credit_type: credit_type, amount: 5, date: '2023-11-01')
end

When('the credit mailer is generated') do
  @mail = CreditMailer.send_pending_credits_email(@user, { 'ExampleCreditType' => { sum_of_credits: 5, total_credit_limit: 20 } }, 10)
end

Then('the email should contain:') do |expected_content|
  # Split the expected content into key phrases or specific content
  key_phrases = expected_content.split(/\n+/).map(&:strip)

  # Combine regex patterns for <p>, <h2>, and <h4> tags
  regex_pattern = /<(p|h2|h4)>(.*?)<\/\1>/im

  # Extract text content from all matching tags in the email using regex
  actual_content = @mail.body.encoded.scan(regex_pattern).map(&:last)

  # Check if each key phrase is present in the actual content
  key_phrases.each do |key_phrase|
    expect(actual_content.join(' ')).to include(key_phrase)
  end
end

