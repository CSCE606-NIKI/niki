# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  current_user_count = User.count
  describe 'POST #create' do
    it 'create user fails due to missing special character in password' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'Password123', password_confirmation: 'Password123' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'create user fails due to missing lowercase character in password' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'PASSWORD123', password_confirmation: 'PASSWORD123' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'create user fails due to missing uppercase character in password' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'password123', password_confirmation: 'password123' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'create user fails due to missing digit in password' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'Password@', password_confirmation: 'Password@' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'create user fails due to shorter password' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'Pa12@', password_confirmation: 'Pa12@' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'create user fails due to password mismatch' do
      post :create, params: { user: { username: 'test_user1', email: 'test1@example.com', password: 'Password123!', password_confirmation: 'Password123' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count) # No user should be created
    end

    it 'creates a new user with unique email' do
      post :create, params: { user: { username: 'test_user2', email: 'test2@example.com', password: 'Password123!', password_confirmation: 'Password123!' } }

      expect(response).to redirect_to(renewal_date_user_path(User.last))
      expect(User.count).to eq(current_user_count + 1) # 1 user should be created.
    end

    it 'does not create a new user if email is not unique' do
      # Create a user with the same email as in the test
      User.create(username: 'existing_user', email: 'test2@example.com', password_digest: 'Password123!')
      post :create, params: { user: { username: 'existing_user', email: 'test2@example.com', password: 'Password123!', password_confirmation: 'Password123!' } }

      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count + 1) # Should still be 1, not 2
    end

    it 'does not create a new user if username is already in use' do
      # Create a user with the same username as in the test.
      User.create(username: 'test_user2', email: 'test2@example.com', password_digest: 'Password123!')
      post :create, params: { user: { username: 'test_user2', email: 'test2@example.com', password: 'Password123!', password_confirmation: 'Password123!' } }

      
      # expect(response).to redirect_to(new_user_path)
      expect(User.count).to eq(current_user_count + 1) # Should still be 1, not 2
    end
  end
end

