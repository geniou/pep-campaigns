require 'spec_helper'

feature 'Admin application' do

  scenario 'Delete an application' do
    campaign_with_application_and_references_exists
    admin_exists_and_is_logged_in

    visit_admin_campaign_page
    delete_application
    application_and_refrence_should_be_deleted
  end

  let(:campaign) { create(:campaign) }
  let(:applicant) { create(:applicant_contact) }

  def campaign_with_application_and_references_exists
    create(:application, campaign: campaign, contact: applicant) do |application|
      create(:reference, application: application)
    end
  end

  def visit_admin_campaign_page
    visit admin_campaign_path(campaign)
  end

  def delete_application
    page.should have_selector('td', text: applicant.name)
    click_button('löschen')
  end

  def application_and_refrence_should_be_deleted
    Application.count.should == 0
    Contact::Applicant.count.should == 0
    Reference.count.should == 0
    Contact::Referee.count.should == 0
    page.should_not have_selector('td', text: applicant.name)
  end
end
