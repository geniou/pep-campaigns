require 'spec_helper'

feature 'Admin application questions' do

  scenario 'List all answers to an application' do
    application_with_an_answer_exists
    admin_exists_and_is_logged_in

    go_to_admin_application_page
    see_all_answers_of_the_application
  end

  scenario 'Change answers' do
    application_with_an_answer_exists
    admin_exists_and_is_logged_in

    go_to_admin_application_page
    change_answer
  end

  def application_with_an_answer_exists
    create(:campaign) do |campaign|
      @application = create(:application,
             campaign: campaign,
            )
      create(:text_question,
             campaign: campaign,
             for: :application,
             text: 'Question 1',
             answer: 'Answer 1',
             application: @application
            )
    end
  end

  def go_to_admin_application_page
    visit admin_application_path(@application.id)
  end

  def see_all_answers_of_the_application
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
