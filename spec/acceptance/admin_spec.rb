require 'spec_helper'

feature 'Admin section' do

  scenario 'Get login screen before admin section' do
    admin_user_exists
    go_to_admin_section
    need_to_login
    login
    see_admin_section
  end

  def admin_user_exists
    Admin.create!(email: 'admin@example.com', password: '123456')
  end

  def go_to_admin_section
    visit '/admin'
  end

  def need_to_login
    page.should_not have_selector('h1', text: 'Kampagnen')
    page.should have_selector('h2', text: 'Sign in')
  end

  def login
    fill_in 'admin_email', with: 'admin@example.com'
    fill_in 'admin_password', with: '123456'
    click_button('Sign in')
    page.should have_selector('.notice', text: 'Erfolgreich angemeldet.')
  end

  def see_admin_section
    page.should have_selector('h1', text: 'Kampagnen')
  end
end
