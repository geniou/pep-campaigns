require 'spec_helper'

feature 'Admin reference' do

  scenario 'Delete reference' do
    application_with_reference_exists
    admin_exists_and_is_logged_in

    visit_admin_application_page
    delete_reference
    refrence_should_be_deleted
  end

  let(:campaign) { create(:campaign) }
  let(:application) { create(:application, campaign: campaign) }
  let(:referee) { create(:referee_contact) }

  def application_with_reference_exists
    create(:reference, application: application, contact: referee)
  end

  def visit_admin_application_page
    visit admin_application_path(application)
  end

  def delete_reference
    page.should have_selector('td', text: referee.name)
    click_button('löschen')
  end

  def refrence_should_be_deleted
    Reference.count.should == 0
    Contact::Referee.count.should == 0
    page.should_not have_selector('td', text: referee.name)
  end
end
