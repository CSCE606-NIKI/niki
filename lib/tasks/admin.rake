namespace :admin do
    desc "Assign admin/standard user roles to all existing users"
    task :assign_roles => [ :environment ] do
        # Your task logic here
        @users = User.all
        @users.each do |u|
            if (u.username != 'admin')
                u.admin = false
            else
                u.admin = true
            end
            u.save
        end 
    end
end