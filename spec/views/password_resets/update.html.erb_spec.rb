# spec/views/password_resets/update.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'password_resets/update.html.erb', type: :view do
  it 'displays a success message indicating the password has been updated' do
    render
    expect(rendered).to have_content('Password has been successfully updated.')
  end
end
