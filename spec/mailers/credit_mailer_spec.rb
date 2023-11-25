# spec/mailers/credit_mailer_spec.rb
require 'rails_helper'

RSpec.describe CreditMailer, type: :mailer do
  let(:user) do
    User.create!(username: 'ExistingUsername', email: 'existing@example.com', password: 'password1234')
  end

  describe '#send_pending_credits_email' do
    it 'sends the pending credits email' do
      credit_progress = { 'Credit Type 1' => { sum_of_credits: 50, total_credit_limit: 100 } }
      pending_credits = 50

      mail = CreditMailer.send_pending_credits_email(user, credit_progress, pending_credits)

      expect(mail.subject).to eq('Pending Credits to complete in the Renewal period.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com']) # Update with your email address
      expect(mail.body.encoded).to include('Your renewal date is approaching:')
      # Add more expectations based on your email content
    end
  end
end
