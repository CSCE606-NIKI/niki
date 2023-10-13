class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
      
    end
      flash[:alert] = 'If an account with that email was found, we have sent a link to reset the password'
      redirect_to login_path
  end

  
  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:alert] = 'Your token has expired. Please try again'
    redirect_to password_resets_update_path
  end

  def update
    begin
      @user = User.find_signed!(params[:token], purpose: 'password_reset')
      if @user.update(password_params)
        flash[:alert] = 'Your password was reset succesfully. Please log in.'
        redirect_to login_path
      else
        render 'edit'
      end
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        flash[:alert] = 'Your token has expired. Please try again'
      redirect_to password_reset_path
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
