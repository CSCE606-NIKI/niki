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

end
