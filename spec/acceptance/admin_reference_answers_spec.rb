require 'spec_helper'

feature 'Admin reference questions' do

  scenario 'List all answers to an reference' do
    reference_with_an_answer_exists
    admin_exists_and_is_logged_in

    go_to_admin_reference_page
    see_all_answers_of_the_reference
  end

  scenario 'Change answers' do
    reference_with_an_answer_exists
    admin_exists_and_is_logged_in

    go_to_admin_reference_page
    change_answer
  end

  def reference_with_an_answer_exists
    create(:campaign) do |campaign|
      create(:contact) do |contact|
        create(:application, campaign: campaign, contact: contact) do |application|
          create(:reference, campaign: campaign, contact: contact,
                 application: application) do |reference|
            create(:text_question,
                   campaign: campaign,
                   for: :reference,
                   text: 'Question 1',
                   answer: 'Answer 1',
                   application: application,
                   reference: reference
                  )
          end
        end
      end
    end
  end

  def go_to_admin_reference_page
    visit admin_reference_path(Reference.first.id)
  end

  def see_all_answers_of_the_reference
    page.should have_content 'Question 1'
    page.should have_content 'Answer 1'
  end

  def change_answer
    click_link('bearbeiten')
    fill_in 'Question 1', with: "New answer 1"
    click_button("Speichern")
    page.should have_content 'New answer 1'
  end
end

