describe 'password_resets/new.html.erb', type: :view do
  it 'displays the forgot password form with an input field and a reset button' do
    render
    expected_action = "/password/reset"
    expect(rendered).to have_selector("form[action='#{expected_action}'][method='post']")
    expect(rendered).to have_field('Email', type: 'email')
    expect(rendered).to have_button('Reset Password')
  end
end
