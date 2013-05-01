require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Application" do

  include AcceptanceHelpers

  scenario "See application" do
    campaign_with_applicant_introduction_text_exists
    go_to_application_submission_page
    see_applicant_introduction_text
  end

  scenario "Submit a new application" do
    campaign_with_questions_exists

    go_to_application_submission_page
    fill_in_application_details

    see_application_submitted_landing
  end

  def campaign_with_applicant_introduction_text_exists
    create(:campaign, applicant_introduction_text: 'Introduction text')
  end

  def campaign_with_questions_exists
    create(:campaign) do |campaign|
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

  def go_to_application_submission_page
    visit new_campaign_application_path(Campaign.first)
  end

  def see_applicant_introduction_text
    page.should have_selector('.introduction', text: 'Introduction text')
  end

  def fill_in_application_details
    fill_in_contact_details

    fill_in 'Question 1', with: "Answer 1"
    choose '1'
    choose 'Q3A2'

    click_button("Jetzt bewerben")
  end

  def see_application_submitted_landing
    page.should have_selector('h1', text: "Success!")

    application = Application.first
    application.contact.last_name.should == "Person"
  end

end
