require 'spec_helper'

feature 'Application summary' do

  scenario 'Export application data' do
    reference_with_answers_exist
    admin_exists_and_is_logged_in

    go_to_admin_application_summary_page
    see_summary
  end

  def reference_with_answers_exist
    create(:campaign) do |campaign|
      create(:applicant_contact) do |contact|
        create(:application, campaign: campaign, contact: contact) do |application|
          create(:text_question, campaign: campaign, for: :reference, text: 'Question 1',
                 answer: 'Answer 1', application: application) do |question|
            create(:reference, campaign: campaign, contact: contact,
                   application: application) do |reference|
              create(:answer, question: question, reference: reference, text_value: 'Answer 1')
            end
            create(:reference, campaign: campaign, contact: contact,
                   application: application) do |reference|
              create(:answer, question: question, reference: reference, text_value: 'Answer 2')
            end
          end
        end
      end
    end
  end

  def go_to_admin_application_summary_page
    visit references_admin_application_summary_path(Application.first.id)
  end

  def see_summary
    page.should have_selector('h2', text: 'Question 1')
    page.should have_content('Answer 1')
    page.should have_content('Answer 2')
  end
end
