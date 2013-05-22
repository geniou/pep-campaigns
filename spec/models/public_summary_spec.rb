require 'spec_helper'

describe PublicSummary do

  describe 'references' do
    subject { summary.references }
    let(:summary) { PublicSummary.new(Application.first.summary_key) }
    before do
      create(:campaign) do |campaign|
        create(:text_question, for: :reference, campaign: campaign,
              text: 'Question 1') do |question|
          create(:application, campaign: campaign) do |application|
            create(:reference, application: application) do |reference|
              create(:answer, question: question, reference: reference,
                     text_value: 'Answer Q1-1')
            end
            create(:reference, application: application) do |reference|
              create(:answer, question: question, reference: reference,
                     hide_on_summary: true, text_value: 'Answer Q1-2')
            end
          end
          create(:application, campaign: campaign) do |application|
            create(:reference, application: application) do |reference|
              create(:answer, question: question, reference: reference,
                     text_value: 'Answer Q1-3')
            end
          end
        end
        create(:text_question, for: :reference, campaign: campaign,
              hide_on_summary: true, text: 'Question 2')
      end
    end

    it 'returns all non hidden questions' do
      subject[:questions].map{ |q| q.first }.should == ['Question 1']
    end

    it 'returns question summary_type' do
      subject[:questions].first[1].should == :list
    end

    it 'returns application answers to question' do
      subject[:questions].first[2].map(&:value).should == ['Answer Q1-1']
    end

    it 'returns all answers to question' do
      subject[:questions].first[3].map(&:value).should == ['Answer Q1-1', 'Answer Q1-3']
    end

    it 'returns number of references' do
      subject[:count].should == 2
    end
  end
end

