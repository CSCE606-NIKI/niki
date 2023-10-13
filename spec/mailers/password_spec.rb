# require "rails_helper"

# RSpec.describe PasswordMailer, type: :mailer do
#   describe "reset" do
#     let(:mail) { PasswordMailer.reset }

#     it "renders the headers" do
#       expect(mail.subject).to eq("Reset Password")
#       expect(mail.to).to eq([user.email])
#       expect(mail.from).to eq(["from@example.com"])
#     end

#     it "renders the body" do
#       expect(mail.body.encoded).to include("Hi #{user.username}")
#       expect(mail.body.encoded).to match(password_reset_edit_url(token: user.signed_id(purpose: 'password_reset', expires_in: 30.minutes)))
#     end
#   end

# end

# spec/mailers/password_mailer_spec.rb

require 'rails_helper'

RSpec.describe PasswordMailer, type: :mailer do
  let(:user) { create(:user, email: 'valid@example.com') }

  it 'sends a password reset email' do
    email = PasswordMailer.with(user: user).reset
    expect(email.subject).to eq('Password Reset')
    expect(email.to).to eq([user.email])
    # Add other expectations if needed to verify the email content
    #puts email.body.to_s
    #expect(email.body.to_s).to include('Click the link below to reset your password:')
  end
end




