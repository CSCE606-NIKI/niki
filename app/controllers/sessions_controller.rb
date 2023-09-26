class SessionsController < ApplicationController
  def new
  end

  def create
    identifier = login_params[:identifier]
    user = if identifier.include?('@')  # Check if it looks like an email
      User.find_by('lower(email) = ?', identifier.downcase)
    else
      User.find_by('lower(username) = ?', identifier.downcase)
    end
    puts user
    if user && user.authenticate(login_params[:password])
        session[:user_id] = user.id
        redirect_to '/'
    else
        flash[:danger] =['Invalid email/password combination']
        render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'Logged out successfully'
  end

  private
  def login_params
      params.require(:login).permit(:email, :password , :username, :identifier)
  end 

  private
  def find_user_by_username_or_email(identifier)
    User.find_by('lower(username) = ? OR lower(email) = ?', identifier.downcase, identifier.downcase)
  end
end
