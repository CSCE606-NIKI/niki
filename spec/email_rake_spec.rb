# spec/tasks/email_check_rake_spec.rb
require 'rails_helper'
require 'rake'

RSpec.describe 'email:check_renewal_date_to_email' do
  before do
    Rails.application.load_tasks # Load your Rake tasks
  end

  it 'creates a user, credit types, and credits before invoking the Rake task' do
    # Assuming you have the necessary user and credit_type_without_carry_forward objects
    user = FactoryBot.create(:user_with_different_renewal_date)
    credit_type_without_carry_forward = FactoryBot.create(:credit_type_without_carry_forward)

    # Create a credit record directly without using a POST request
    valid_credit_attributes = {
      credit_type_id: credit_type_without_carry_forward.id,
      date: '2023-10-11',
      amount: 150,
      description: 'Test Text'
    }

    # Create a credit record for the user
    credit = FactoryBot.create(:credit, user: user, **valid_credit_attributes)

    # Calculate the expected total for the current year (2023)
    expected_total = valid_credit_attributes[:amount]

    # Check the actual total in the database
    actual_total = user.credits.where(credit_type: credit_type_without_carry_forward, date: Date.new(2023, 1, 1)..Date.new(2023, 12, 31)).sum(:amount)

    # Assert that the actual total matches the expected total
    expect(actual_total).to eq(expected_total)

    expect {
        Rake::Task['email:check_renewal_date_to_email'].invoke
      }.to output(/Sending email to:/).to_stdout

      # Reset the standard output
      $stdout = STDOUT
  end
end
