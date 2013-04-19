require 'spec_helper'

feature 'Admin contacts' do

  background do
    admin_exists_and_is_logged_in
  end

  scenario 'List of contacts' do
    application_and_reference_contacts_exist
    visit_admin_contact_list_page
    see_all_contacts
  end

  def application_and_reference_contacts_exist
    create(:campaign, name: 'The campaign') do |campaign|
      create(:contact, last_name: 'Application contact') do |application_contact|
        create(:application, campaign: campaign, contact: application_contact) do |application|
          create(:contact, last_name: 'Reference contact') do |reference_contact|
            create(:reference, campaign: campaign,
                   application: application, contact: reference_contact)
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
