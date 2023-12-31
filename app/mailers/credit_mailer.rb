# app/mailers/credit_mailer.rb
class CreditMailer < ApplicationMailer
  def send_pending_credits_email(user, credit_progress, pending_credits)
    @user = user
    @credit_progress = credit_progress
    @pending_credits = pending_credits
    @renewal_date = user.renewal_date
    @token = @user.signed_id(purpose: 'pending_credits', expires_in: 30.minutes)
    mail(to: @user.email, subject: 'Pending Credits to complete in the Renewal period.') do |format|
      format.html { render 'send_pending_credits_email' }
    end
  end
end