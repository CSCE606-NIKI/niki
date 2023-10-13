class ProfileController < ApplicationController
    def edit
        @user = current_user
    end
      
    def update
        @user = current_user
        if @user.update(user_params)
          redirect_to dashboard_path, notice: 'Profile updated successfully.'
        else
          render :edit
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :email, :profile_pic) # Permit only username and email
    end
end
