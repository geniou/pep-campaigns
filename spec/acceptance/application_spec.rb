require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Application" do

  include AcceptanceHelpers

  scenario "Submit a new application" do
    campaign_exists

    go_to_application_submission_page
    fill_in_application_details

    see_application_submitted_landing
  end

  def campaign_exists
    @campaign = create(:campaign)
  end

  def go_to_application_submission_page
    visit new_campaign_application_path(@campaign)
  end

  def fill_in_application_details
    fill_in_contact_details
    select "2011", :from => 'application_contact_attributes_birthdate_1i'
    select "January", :from => 'application_contact_attributes_birthdate_2i'
    select "1", :from => 'application_contact_attributes_birthdate_3i'
    fill_in 'application_name', :with => "The Application Name"
    click_button("Jetzt bewerben")
  end

  def see_application_submitted_landing
    page.should have_selector('h1', text: "Success!")

    application = Application.find_by_name('The Application Name')
    application.contact.last_name.should == "Person"
  end

end
