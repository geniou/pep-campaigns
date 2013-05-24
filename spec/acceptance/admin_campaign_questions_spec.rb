#-*- coding: utf-8 -*
require 'spec_helper'

feature 'Admin campaign questions' do

  scenario 'List all campaign questions' do
    campaign_with_questions_exists
    admin_exists_and_is_logged_in

    go_to_admin_campaign_questions_page
    see_all_questions_of_the_campaign
  end

  scenario 'Create new campaign text question' do
    campaign_exists
    admin_exists_and_is_logged_in

    create_new_campaign_text_question
    see_new_campaign_question
  end

  scenario 'Create new campaign select question' do
    campaign_exists
    admin_exists_and_is_logged_in

    create_new_campaign_select_question
    see_new_campaign_question
  end

  def campaign_exists
    create(:campaign)
  end

  def campaign_with_questions_exists
    create(:campaign).tap do |campaign|
      create(:text_question, for: :application, campaign: campaign, text: 'What should we know?')
    end
  end

  def go_to_admin_campaign_questions_page
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'Fragen anzeigen'
  end

  def see_all_questions_of_the_campaign
    page.should have_selector('table.questions')
    page.should have_selector('table.questions tbody tr', text: 'What should we know?')
  end

  def create_new_campaign_text_question
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'Fragen anzeigen'
    click_link 'Frage anlegen'

    select 'Bewerbung', from: 'question_for'
    select 'Textzeile', from: 'question_type'
    fill_in 'question_text', with: 'What should we know about you?'
    click_button('Fragen anlegen')
  end

  def create_new_campaign_select_question
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'Fragen anzeigen'
    click_link 'Frage anlegen'

    select 'Bewerbung', from: 'question_for'
    select 'Auswahl', from: 'question_type'
    fill_in 'question_options', with: 'A, B, C'
    fill_in 'question_text', with: 'What should we know about you?'
    click_button('Fragen anlegen')

    Question.first.options.should == ["A","B","C"]
  end

  def see_new_campaign_question
    page.should have_selector('.notice', text: 'Frage gespeichert')
    page.should have_selector('td', text: 'What should we know about you?')
  end
end
