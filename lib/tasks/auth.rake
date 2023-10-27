namespace :auth do
    desc "Add an auth token to all existing users to enable login"
    task :generate_tokens => [ :environment ] do
        # Your task logic here
        @users = User.all
        @users.each do |u|
            begin
                u[:auth_token] = SecureRandom.urlsafe_base64
            end while User.exists?(auth_token: u[:auth_token])
            u.save
        end 
    end
end