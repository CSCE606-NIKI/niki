Given 'I am a new user and I am on the sign up page' do
    visit new_user_path
end

Given 'I am an existing user and I am on the login page' do
    visit login_path
end

When 'I click "Sign up with Google" and choose my valid Google account' do
    click_button "Sign up with Google"
end

When 'I click "Sign up with Google" and choose my invalid Google account' do
    click_button "Sign up with Google"
end

When 'I click "Log in with Google" and choose my valid Google account' do 
    click_button "Log in with Google"
end

Given 'someone else has already registered with my email' do
    @user = User.create(username: "John Doe", 
                        email: "john@company_name.com", 
                        uid: "646534", 
                        provider: "facebook", 
                        password: "password", 
                        password_confirmation: "password")
    @user.save!
end
  

