require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Reference" do

  include AcceptanceHelpers

  scenario "Submit a new reference" do
    application_exists
    go_to_reference_submission_page
    fill_in_reference_details
    see_reference_submitted_landing
  end

  def application_exists
    @campaign = create(:campaign)
    @application = create(:application, :campaign => @campaign)
  end

  def go_to_reference_submission_page
    visit new_campaign_application_reference_path(@campaign, @application)
  end

  def fill_in_reference_details
    fill_in_contact_details
    select "2011", :from => 'reference_contact_attributes_birthdate_1i'
    select "January", :from => 'reference_contact_attributes_birthdate_2i'
    select "1", :from => 'reference_contact_attributes_birthdate_3i'
    click_button("Submit")
  end

  def see_reference_submitted_landing
    page.should have_selector('h1', text: "Thanks!")

    Reference.first.contact.last_name.should == 'Person'
  end

end
