require 'spec_helper'

describe Summary do

  let(:summary) { Summary.new(Application.first) }
  before do
    create(:campaign) do |campaign|
      create(:text_question, for: :reference, campaign: campaign, text: 'Question 1') do |question|
        create(:application, campaign: campaign) do |application|
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference, text_value: 'Answer Q1-1')
          end
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference, text_value: 'Answer Q1-2')
          end
        end
        create(:application, campaign: campaign) do |application|
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference, text_value: 'Answer Q1-3')
          end
        end
      end
      create(:text_question, for: :reference, campaign: campaign, text: 'Question 2')
    end
  end

  describe 'reference_questions' do
    subject { summary.reference_questions }

    it 'returns all questions' do
      subject.map{ |q| q.first }.should == ['Question 1', 'Question 2']
    end

    it 'returns question summary_type' do
      subject.first[1].should == :list
    end

    it 'returns application answers to question' do
      subject.first[2].map(&:value).should == ['Answer Q1-1', 'Answer Q1-2']
    end

    it 'returns all answers to question' do
      subject.first[3].map(&:value).should == ['Answer Q1-1', 'Answer Q1-2', 'Answer Q1-3']
    end
  end

  describe 'number_of_references' do
    subject { summary.number_of_references }
    it { should == 2 }
  end
end
