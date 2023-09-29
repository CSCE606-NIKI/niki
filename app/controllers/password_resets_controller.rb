class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      PasswordMailer.with(user: @user).reset.deliver_later
      redirect_to '/login', notice: 'If an account with that email was found, we have sent a link to reset the password'
    else
      puts "Email not found: #{params[:email]}"
      flash.now[:danger] = 'Email not found'
      render 'new'
    end
  end

  
  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_reset_path, alert: 'Your token has expired. Please try again'
  end

  def update
    begin
      @user = User.find_signed!(params[:token], purpose: 'password_reset')
      if @user.update(password_params)
        redirect_to login_path , notice: 'Your password was reset succesfully. Please sign in.'
      else
        render 'edit'
      end
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_reset_path, alert: 'Your token has expired. Please try again'
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
