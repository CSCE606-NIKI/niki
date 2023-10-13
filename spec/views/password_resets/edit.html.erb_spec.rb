# spec/views/password_resets/edit.html.erb_spec.rb
# require 'rails_helper'

# RSpec.describe 'password_resets/edit.html.erb', type: :view do
#   let(:user) { create(:user) }
#   let(:token) { user.signed_id(purpose: 'password_reset', expires_in: 30.minutes) }
#   it 'displays the password reset form with input fields' do
#     assign(:token, token)
#     render
#     expected_action = password_reset_path(token: token)
#     expect(rendered).to have_selector("form[action='#{expected_action}'][method='patch']")
#     expect(rendered).to have_field?('user[password]', type: 'password')
#     expect(rendered).to have_field?('user[password_confirmation]', type: 'password')
#     expect(rendered).to have_button('Reset Password')
#   end

# end
