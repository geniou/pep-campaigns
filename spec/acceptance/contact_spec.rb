require 'spec_helper'

feature 'Contact' do

  scenario 'See contact questions on application' do
    campaign_with_a_applicant_question_exists
    visit_application_form
    see_contact_question
  end

  scenario 'See contact questions on reference' do
    campaign_with_a_referee_question_exists
    visit_reference_form
    see_contact_question
  end

  def campaign_with_a_applicant_question_exists
    create(:campaign) do |campaign|
      create(:text_question, campaign: campaign, for: :applicant, text: 'Contact question')
    end
  end

  def campaign_with_a_referee_question_exists
    create(:campaign) do |campaign|
      create(:application, campaign: campaign) do |application|
        create(:text_question, campaign: campaign, application: application, for: :referee, text: 'Contact question')
      end
    end
  end

  def visit_application_form
    visit new_campaign_application_path(Campaign.first)
  end

  def visit_reference_form
    visit new_campaign_application_reference_path(Campaign.first, Application.first)
  end

  def see_contact_question
    page.should have_content('Contact question')
  end
end
