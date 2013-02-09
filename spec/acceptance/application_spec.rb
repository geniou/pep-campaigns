require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Application" do

  include AcceptanceHelpers

  scenario "Submit a new application" do
    campaign_exists 
    go_to_application_submission_page
    fill_in_contact_details
    fill_in_application_details
    submit_application
    see_application_submitted_landing
  end

  def campaign_exists 
    @campaign = FactoryGirl.create(:campaign)
  end

  def go_to_application_submission_page
    visit new_campaign_application_path(@campaign)
  end

  def fill_in_application_details
    fill_in 'application_name', :with => "That for which I am applying"
  end

  def submit_application
    click_button("Jetzt bewerben")
  end

  def see_application_submitted_landing
    page.should have_selector('h1', text: "Success!")
  end

end
