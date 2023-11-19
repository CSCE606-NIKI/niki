# app/mailers/credit_mailer.rb
class CreditMailer < ApplicationMailer
  def send_pending_credits_email(user)
    @user = current_user
    @token = @user.signed_id(purpose: 'pending_credits', expires_in: 30.minutes)
    mail(to: @user.email, subject: 'Pending Credits to complete in the Renewal period.')
  end
end
