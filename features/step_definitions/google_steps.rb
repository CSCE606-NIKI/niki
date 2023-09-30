Given 'I am a new user and I am on the sign up page' do
    visit new_user_path
end

Given 'I am an existing user and I am on the login page' do
    visit login_path
end

When 'I click "Sign up with Google" and choose my valid TAMU account' do
    click_button "Sign up with Google"
end

When 'I click "Sign up with Google" and choose my invalid TAMU account' do
    click_button "Sign up with Google"
end

When 'I click "Log in with Google" and choose my valid TAMU account' do 
    click_button "Log in with Google"
end

When 'I click "Log in with Google" and choose my invalid TAMU account' do 
    click_button "Log in with Google"
end

