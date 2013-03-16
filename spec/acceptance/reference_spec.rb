require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Reference" do

  include AcceptanceHelpers

  scenario "Submit a new reference" do
    application_with_question_exists

    go_to_reference_submission_page
    fill_in_reference_details

    see_reference_submitted_landing
  end

  def application_with_question_exists
    @campaign = create(:campaign)
    @application = create(:application, :campaign => @campaign)
    @campaign.reference_questions << create(:text_question, for_application: false, text: 'Question 1')
  end

  def go_to_reference_submission_page
    visit new_campaign_application_reference_path(@campaign, @application)
    page.should have_selector("#referee_introduction_text")
  end

  def fill_in_reference_details
    fill_in_contact_details
=begin
    These fields are optional now @see Case 46320811

    select "2011", :from => 'reference_contact_attributes_birthdate_1i'
    select "January", :from => 'reference_contact_attributes_birthdate_2i'
    select "1", :from => 'reference_contact_attributes_birthdate_3i'
=end

    fill_in 'Question 1', :with => "Answer 1"

    click_button("Submit")
  end

  def see_reference_submitted_landing
    page.should have_selector('h1', text: "Thanks!")

    Reference.first.contact.last_name.should == 'Person'
  end

end
