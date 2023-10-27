class WelcomeController < ApplicationController
  def index
    # If user goes to the root path, redirect them to the login page if they're already logged in
    if logged_in?
      redirect_to dashboard_path # Redirect logged-in users to their profile
    end
  end
end
