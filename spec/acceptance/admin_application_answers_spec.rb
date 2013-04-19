require 'spec_helper'

feature 'Admin application questions' do

  scenario 'List all answers to an application' do
    application_with_answers_exists
    admin_exists_and_is_logged_in

    go_to_admin_application_page
    see_all_answers_of_the_application
  end

  def application_with_answers_exists
    create(:campaign) do |campaign|
      create(:contact) do |contact|
        @application = create(:application,
               campaign: campaign,
               contact: contact
              );
        create(:text_question,
               campaign: campaign,
               for_application: true,
               text: 'Question 1',
               answer: 'Answer 1',
               application: @application
              )
      end
    end
  end

  def go_to_admin_application_page
    visit admin_application_path(@application.id)
  end

  def see_all_answers_of_the_application
    page.should have_content 'Question 1'
    page.should have_content 'Answer 1'
  end
end
