require 'rails_helper'

RSpec.feature 'Homepage' do
  before do
    visit root_path
  end
  it 'displays the "CE Tracker" navbar link' do
    expect(page).to have_link('CE Tracker', href: '#')
  end

  it 'displays a welcome message' do
    expect(page).to have_content('Welcome to CE Tracker')
  end

  it 'displays a message about managing education credits' do
    expect(page).to have_content('Your One-Stop Solution for Managing Continuing Education Credits')
  end
  
  it 'displays a message about education progress' do
    expect(page).to have_content('Discover the Easiest Way to Keep Track of Your Education Progress')
  end

  it 'contains a "Login" button' do
    expect(page).to have_link('Login', href: '/login')
  end

  it 'contains a "Sign Up" button' do
    expect(page).to have_link('Sign Up', href: '/users/new')
  end

  it 'allows clicking on the "Login" button' do
    click_link 'Login'
    expect(current_path).to eq('/login') 
  end
  
  it 'allows clicking on the "Sign Up" button' do
    click_link 'Sign Up'
    expect(current_path).to eq('/users/new') 
  end
  

  it 'displays the CE Tracker logo' do
    expect(page).to have_css('a.nav-link', text: 'CE Tracker')
  end

  it 'contains a "CE Tracker" navbar link that scrolls to the top of the page' do
    click_link 'CE Tracker'
    expect(page).to have_css('h1') 
  end

end




