class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path # Redirect logged-in users to their profile
    else
      @user = User.new
    end
  end

  def create
    identifier = params[:identifier]

    @user = if identifier.include?('@')  # Check if it looks like an email
      User.find_by('lower(email) = ?', identifier.downcase)
    else
      User.find_by('lower(username) = ?', identifier.downcase)
    end
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
    else
        flash[:danger] ='Invalid credentials'
        redirect_to login_path(@user)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'Logged out successfully'
  end

  private
  def find_user_by_username_or_email(identifier)
    User.find_by('lower(username) = ? OR lower(email) = ?', identifier.downcase, identifier.downcase)
  end

  def require_login
    unless current_user
      flash[:error] = 'You must be logged in to log out.'
      redirect_to root_path
    end
  end

end
