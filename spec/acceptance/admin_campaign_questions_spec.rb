#-*- coding: utf-8 -*
require 'spec_helper'

feature 'Admin campaign questions' do

  scenario 'List all campaign questions' do
    campaign_with_questions_exists
    admin_exists_and_is_logged_in

    go_to_admin_campaign_questions_page
    see_all_questions_of_the_campaign
  end

  scenario 'Create new campaign question' do
    campaign_exists
    admin_exists_and_is_logged_in

    create_new_campaign_question
    see_new_campaign_question
  end

  def campaign_exists
    create(:campaign)
  end

  def campaign_with_questions_exists
    create(:campaign).tap do |campaign|
      create(:application_question, campaign: campaign, text: 'What should we know?')
    end
  end

  def admin_exists_and_is_logged_in
    create(:admin).tap do |admin|
      visit '/admin'
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: admin.password
      click_button('Sign in')
    end
  end

  def go_to_admin_campaign_questions_page
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'Fragen anzeigen'
  end

  def see_all_questions_of_the_campaign
    page.should have_selector('table.questions')
    page.should have_selector('table.questions tbody tr', count: 1)
    page.should have_selector('table.questions tbody tr', text: 'What should we know?')
  end

  def create_new_campaign_question
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'Fragen anzeigen'
    click_link 'Frage anlegen'

    select 'für Bewerber', :from => 'question_type'
    fill_in 'question_text', with: 'What should we know about you?'
    click_button('Fragen anlegen')
  end

  def see_new_campaign_question
    page.should have_selector('.notice', text: 'Frage angelegt')
    page.should have_selector('td', text: 'What should we know about you?')
  end
end
