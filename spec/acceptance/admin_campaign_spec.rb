require 'spec_helper'

feature 'Admin campaign section' do

  scenario 'List all campaigns' do
    campaigns_exists
    admin_exists_and_is_logged_in

    go_to_admin_camaign_section
    see_campaigns
  end

  scenario 'Create new campaign' do
    admin_exists_and_is_logged_in

    go_to_campaign_create_page
    create_campaign
  end

  scenario 'Edit campaign' do
    admin_exists_and_is_logged_in
    campaign_exists

    go_to_campaign_form
    change_campaign
    campaign_is_changed
  end

  scenario 'Try to set invalid reference count' do
    admin_exists_and_is_logged_in
    campaign_exists

    go_to_campaign_form

    fill_in 'campaign[required_reference_count]', with: 'some garbage'
    click_button('speichern')

    page.should have_selector('p.inline-errors')
  end

  scenario 'Try to set low reference count' do
    admin_exists_and_is_logged_in
    campaign_exists

    go_to_campaign_form

    fill_in 'campaign[required_reference_count]', with: '0'
    click_button('speichern')

    page.should have_selector('p.inline-errors')
  end

  def campaigns_exists
    create(:campaign, name: 'Campaign 1')
    create(:campaign, name: 'Campaign 2')
  end

  def campaign_exists
    create(:campaign, name: 'The Campaign')
  end

  def go_to_admin_camaign_section
    visit '/admin/campaigns'
  end

  def see_campaigns
    page.should have_selector('table.campaigns')
    page.should have_selector('table.campaigns tbody tr', count: 2)
  end

  def go_to_campaign_create_page
    visit '/admin/campaigns'
    click_link 'Kampagne anlegen'
  end

  def create_campaign
    fill_in 'campaign[name]', with: 'new campaign'
    fill_in 'campaign[referee_introduction_text]', with: 'introductory text'
    fill_in 'campaign[required_reference_count]', with: 5
    click_button('speichern')
  end

  def go_to_campaign_form
    visit '/admin/campaigns'
    click_link 'Campaign'
    click_link 'bearbeiten'
  end

  def change_campaign
    fill_in 'campaign[name]', with: 'The new Campaign'
    click_button('speichern')
  end

  def campaign_is_changed
    page.should have_selector('td', tect: 'The new Campaign')
  end
end
