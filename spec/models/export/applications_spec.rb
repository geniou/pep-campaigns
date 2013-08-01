require 'spec_helper'

describe Export::Applications do

  describe 'data' do
    subject { described_class.new([Application.first]).data([]) }
    before do
      create(:campaign) do |campaign|
        create(:text_question, for: :referee, campaign: campaign,
                                                text: 'Question R1') do |referee_question|
          create(:text_question, for: :reference, campaign: campaign,
                                                  text: 'Question 1') do |reference_question|
            create(:application, campaign: campaign) do |application|
              create(:referee_contact, first_name: 'FN1', last_name: 'LN1', email: 'EM1') do |referee_contact|
                create(:reference, application: application, contact: referee_contact) do |reference|
                  create(:answer, question: referee_question, reference: reference,
                                  text_value: 'Answer QR1-1')
                  create(:answer, question: reference_question, reference: reference,
                                  text_value: 'Answer Q1-1')
                end
              end
              create(:referee_contact, first_name: 'FN2', last_name: 'LN2', email: 'EM2') do |referee_contact|
                create(:reference, application: application, contact: referee_contact) do |reference|
                  create(:answer, question: referee_question, reference: reference,
                                  text_value: 'Answer QR1-2')
                  create(:answer, question: reference_question, reference: reference,
                                  text_value: 'Answer Q1-2')
                end
              end
            end
          end
        end
        create(:text_question, for: :reference, campaign: campaign, text: 'Question 2')
      end
    end

    it 'returns all contacts' do
      values_at('First name').should == ['FN1', 'FN2']
      values_at('Last name').should == ['LN1', 'LN2']
      values_at('eMail').should == ['EM1', 'EM2']
    end

    it 'returns all referee answers' do
      values_at('Question R1').should == ['Answer QR1-1', 'Answer QR1-2']
    end

    it 'returns all reference answers' do
      values_at('Question 1').should == ['Answer Q1-1', 'Answer Q1-2']
    end
  end

  def values_at(name)
    subject[1..-1].map{ |row| row[subject[0].index(name)] }
  end
end
