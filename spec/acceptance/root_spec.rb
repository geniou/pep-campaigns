require 'spec_helper'

feature 'Home page' do

  scenario 'Visit home page' do
    visit_home_page
    see_home_page
  end

  def visit_home_page
    visit '/'
  end

  def see_home_page
    page.should have_selector('h1', text: 'Kampagnen')
  end

end
