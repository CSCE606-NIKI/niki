class ProfileController < ApplicationController
    def edit
        @user = current_user
    end
      
       def update
          @user = current_user
          if @user.update(user_params)
            # Check if profile_pic is present and upload it to S3
            if params[:user][:profile_pic].present?
              s3 = Aws::S3::Resource.new
              bucket = s3.bucket('credits-education-tracker') # Replace with your bucket name
              obj = bucket.object("profile_pictures/#{SecureRandom.uuid}/#{params[:user][:profile_pic].original_filename}")
              obj.upload_file(params[:user][:profile_pic].tempfile, acl: 'public-read')
            end
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
