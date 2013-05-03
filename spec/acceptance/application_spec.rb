require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Application" do

  include AcceptanceHelpers

  scenario "Create and finalize a application" do
    campaign_with_questions_exists

    # step 1
    go_to_application_create_page
    see_applicant_introduction_text
    fill_in_applicant_details

    # step 2
    try_and_fail_without_applicant_login
    fill_applicant_login_and_application_answers
  end

  def campaign_with_questions_exists
    create(:campaign, applicant_introduction_text: 'Introduction text') do |campaign|
      campaign.application_questions << create(:text_question,
                                              for: :application,
                                              text: 'Question 1')
      campaign.application_questions << create(:rate_question,
                                              for: :application,
                                              text: 'Question 2')
      campaign.application_questions << create(:select_question,
                                              for: :application,
                                              text: 'Question 3',
                                              options: ['Q3A1', 'Q3A2'])
    end
  end

  def go_to_application_create_page
    visit new_campaign_application_path(Campaign.first)
  end

  def see_applicant_introduction_text
    page.should have_selector('.introduction', text: 'Introduction text')
  end

  def fill_in_applicant_details
    fill_in_contact_details
    fill_in 'Passwort', with: "geheim"
    fill_in 'Passwort bestätigen', with: "geheim"
    click_button("Weiter")

    application = Application.first
    application.contact.last_name.should == "Person"
  end

  def try_and_fail_without_applicant_login
    fill_in_application_answers
    page.should have_content('Bitte überprüfen Sie Ihr Passwort.')
  end

  def fill_applicant_login_and_application_answers
    fill_in 'Passwort', with: "geheim"

    fill_in_application_answers
  end

  private

  def fill_in_application_answers
    fill_in 'Question 1', with: "Answer 1"
    choose '1'
    choose 'Q3A2'

    click_button("Bewerbung abschließen")
  end
end
