require 'spec_helper'

feature 'Admin summary' do

  scenario 'References summary' do
    reference_with_answers_exist
    admin_exists_and_is_logged_in

    go_to_admin_application_summary_page
    see_summary
  end

  scenario 'Hide and show answers', :js do
    reference_with_answer_exist
    admin_exists_and_is_logged_in

    go_to_admin_application_summary_page
    hide_answer
    show_answer
  end

  def reference_with_answers_exist
    create(:campaign) do |campaign|
      create(:applicant_contact) do |applicant_contact|
        create(:application, campaign: campaign, contact: applicant_contact) do |application|
          create(:text_question, campaign: campaign, for: :reference, text: 'Question 1',
                 application: application) do |question|
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

  def reference_with_answer_exist
    create(:campaign) do |campaign|
      create(:applicant_contact) do |applicant_contact|
        create(:application, campaign: campaign, contact: applicant_contact) do |application|
          create(:text_question, campaign: campaign, for: :reference, text: 'Question 1',
                 application: application) do |question|
            create(:referee_contact) do |referee_contact|
              create(:reference, campaign: campaign, contact: referee_contact,
                     application: application) do |reference|
                create(:answer, question: question, reference: reference, text_value: 'Answer 1')
              end
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

  def hide_answer
    click_button('Antwort ausblenden')
    page.should have_selector("input[value='Antwort anzeigen']")
    Answer.first.hide_on_summary.should be_true
  end

  def show_answer
    click_button('Antwort anzeigen')
    page.should have_selector("input[value='Antwort ausblenden']")
    Answer.first.hide_on_summary.should be_false
  end
end
