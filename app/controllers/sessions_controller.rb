class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to dashboard_path # Redirect logged-in users to their profile
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
        redirect_to dashboard_path(@user)
    else
        flash[:danger] ='Invalid credentials'
        redirect_to login_path(@user)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'Logged out successfully'
  end

  def omniauth
    # Create a user object from the response
    # from_omniauth takes care of creating a new user if it doesn't exist yet
    @user = User.from_omniauth(request.env['omniauth.auth']) 
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user)
    else
      # If Google returns an invalid hash, take the user to the login page
      redirect_to '/login', notice: 'Google Authentication failed. Please try again or try a different sign-in method.'
    end
  end

end
