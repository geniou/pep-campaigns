require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Reference" do

  include AcceptanceHelpers

  scenario "Submit a new reference" do
    application_exists 
    go_to_reference_submission_page
    fill_in_contact_details
    fill_in_reference_details
    submit_reference
    see_reference_submitted_landing
  end

  def application_exists
    @campaign = FactoryGirl.create(:campaign)
    @application = FactoryGirl.create(:application, :campaign => @campaign)
  end

  def go_to_reference_submission_page
    visit new_campaign_application_reference_path(@campaign, @application)
  end

  def fill_in_reference_details
  end

  def submit_reference
    click_button("Submit")
  end

  def see_reference_submitted_landing
    page.should have_selector('h1', text: "Thanks!")
  end

end
