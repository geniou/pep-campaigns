require 'spec_helper'

describe Export::Application do

  describe 'data' do
    subject { described_class.new(Application.first).data([]) }
    before do
      create(:campaign) do |campaign|
        create(:text_question, for: :reference, campaign: campaign, text: 'Question 1') do |question|
          create(:application, campaign: campaign) do |application|
            create(:referee_contact, first_name: 'FN1', last_name: 'LN1', email: 'EM1') do |referee_contact|
              create(:reference, application: application, contact: referee_contact) do |reference|
                create(:answer, question: question, reference: reference, text_value: 'Answer Q1-1')
              end
            end
            create(:referee_contact, first_name: 'FN2', last_name: 'LN2', email: 'EM2') do |referee_contact|
              create(:reference, application: application, contact: referee_contact) do |reference|
                create(:answer, question: question, reference: reference, text_value: 'Answer Q1-2')
              end
            end
          end
        end
        create(:text_question, for: :reference, campaign: campaign, text: 'Question 2')
      end
    end

    it 'returns all contacts' do
      subject.map{ |e| e[0..2].join(',') }.should =~ [
        'First name,Last name,eMail', 'FN1,LN1,EM1', 'FN2,LN2,EM2']
    end

    it 'returns all answers' do
      subject.map{ |e| e[3] }.should =~ ['Question 1', 'Answer Q1-1', 'Answer Q1-2']
    end
  end
end
