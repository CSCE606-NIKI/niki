require 'rails_helper'

RSpec.describe 'password_resets/create.html.erb', type: :view do
  it 'displays a message confirming the password reset email was sent' do
    render
    expect(rendered).to have_content('If an account with that email was found, we have sent a link to reset the password')
  end
end
