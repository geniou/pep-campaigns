require 'spec_helper'

feature 'Public summary' do

  scenario 'Application summary' do
    application_with_answers_exist

    go_to_summary_page
    see_application_summary
  end

  scenario 'References summary' do
    reference_with_answers_exist

    go_to_summary_page
    see_reference_summary
  end

  let(:campaign) do
    create(:campaign)
  end
  let(:application) do
    create(:application, campaign: campaign, contact: create(:applicant_contact))
  end

  def application_with_answers_exist
    create(:text_question, campaign: campaign, for: :applicant,
           text: 'Applicant question', answer: "Applicant answer", application: application)
    create(:text_question, campaign: campaign, for: :application,
           text: 'Application question', answer: "Application answer", application: application)
  end

  def reference_with_answers_exist
    create(:text_question, campaign: campaign, for: :reference,
           text: 'Reference question') do |question|
      create(:referee_contact) do |referee_contact|
        create(:reference, campaign: campaign, contact: referee_contact,
               application: application) do |reference|
          create(:answer, question: question, reference: reference, text_value: 'Reference answer 1')
        end
      end
      create(:referee_contact) do |referee_contact|
        create(:reference, campaign: campaign, contact: referee_contact,
               application: application) do |reference|
          create(:answer, question: question, reference: reference, text_value: 'Reference answer 2')
        end
      end
    end
  end

  def go_to_summary_page
    visit summary_path(Application.first.summary_key)
  end

  def see_application_summary
    page.should have_selector('.question', 'Applicant question')
    page.should have_selector('.answer', 'Applicant answer')
    page.should have_selector('.question', 'Application question')
    page.should have_selector('.answer', 'Application answer')
  end

  def see_reference_summary
    page.should have_selector('h2', text: 'Reference question')
    page.should have_content('Reference answer 1')
    page.should have_content('Reference answer 2')
  end
end
