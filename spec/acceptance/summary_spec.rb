require 'spec_helper'

feature 'Public summary' do

  scenario 'References summary' do
    reference_with_answers_exist

    go_to_references_summary_page
    see_summary
  end

  def reference_with_answers_exist
    create(:campaign) do |campaign|
      create(:applicant_contact) do |applicant_contact|
        create(:application, campaign: campaign, contact: applicant_contact) do |application|
          create(:text_question, campaign: campaign, for: :reference, text: 'Question 1',
                 answer: 'Answer 1', application: application) do |question|
            create(:referee_contact) do |referee_contact|
              create(:reference, campaign: campaign, contact: referee_contact,
                     application: application) do |reference|
                create(:answer, question: question, reference: reference, text_value: 'Answer 1')
              end
            end
            create(:referee_contact) do |referee_contact|
              create(:reference, campaign: campaign, contact: referee_contact,
                     application: application) do |reference|
                create(:answer, question: question, reference: reference, text_value: 'Answer 2')
              end
            end
          end
        end
      end
    end
  end

  def go_to_references_summary_page
    visit summary_path(Application.first.summary_key)
  end

  def see_summary
    page.should have_selector('h2', text: 'Question 1')
    page.should have_content('Answer 1')
    page.should have_content('Answer 2')
  end
end
