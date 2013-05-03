require 'spec_helper'

feature 'Admin contacts' do

  background do
    pending
    admin_exists_and_is_logged_in
  end

  scenario 'List of contacts' do
    application_and_reference_contacts_exist
    visit_admin_contact_list_page
    see_all_contacts
  end

  def application_and_reference_contacts_exist
    create(:campaign, name: 'The campaign') do |campaign|
      create(:applicant_contact, last_name: 'Application contact') do |applicant_contact|
        create(:application, campaign: campaign, contact: applicant_contact) do |application|
          create(:referee_contact, last_name: 'Reference contact') do |referee_contact|
            create(:reference, campaign: campaign,
                   application: application, contact: referee_contact)
          end
        end
      end
    end
  end

  def visit_admin_contact_list_page
    visit admin_contacts_path
  end

  def see_all_contacts
    within find("tbody tr:contains('Application contact')") do
      page.should have_selector('a', text: 'The campaign')
    end
  end
end
