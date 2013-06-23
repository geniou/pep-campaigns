require 'spec_helper'

describe PublicSummary do

  let(:summary) { PublicSummary.new(Application.first.summary_key) }
  before do
    create(:campaign) do |campaign|
      create(:text_question, for: :reference, campaign: campaign,
            text: 'Reference question 1') do |question|
        create(:application, campaign: campaign) do |application|
          create(:text_question, for: :applicant, campaign: campaign,
                text: 'Applicant question 1', answer: 'Answer AQ1', application: application)
          create(:text_question, for: :applicant, campaign: campaign, hide_on_summary: true,
                text: 'Applicant question 2', answer: 'Answer AQ2', application: application)
          create(:text_question, for: :application, campaign: campaign,
                text: 'Application question 1', answer: 'Answer PQ1', application: application)
          create(:text_question, for: :application, campaign: campaign, hide_on_summary: true,
                text: 'Application question 2', answer: 'Answer PQ2', application: application)
          create(:text_question, for: :application, campaign: campaign,
                text: 'Application question 3')
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference,
                   text_value: 'Answer RQ1-1')
          end
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference,
                   hide_on_summary: true, text_value: 'Answer RQ1-2')
          end
        end
        create(:application, campaign: campaign) do |application|
          create(:reference, application: application) do |reference|
            create(:answer, question: question, reference: reference,
                   text_value: 'Answer RQ1-3')
          end
        end
      end
      create(:text_question, for: :reference, campaign: campaign,
            hide_on_summary: true, text: 'Reference question 2')
    end
  end

  describe 'applicant_questions' do
    subject { summary.applicant_questions }

    it 'returns all non hidden questions' do
      subject.map{ |q| q.first }.should == ['Applicant question 1']
    end

    it 'returns application answers to question' do
      subject.first[1].should == 'Answer AQ1'
    end
  end

  describe 'application_questions' do
    subject { summary.application_questions }

    it 'returns all non hidden questions' do
      subject.map{ |q| q.first }.should == ['Application question 1', 'Application question 3']
    end

    it 'returns application answers to question' do
      subject.first[1].should == 'Answer PQ1'
    end
  end

  describe 'reference_questions' do
    subject { summary.reference_questions }

    it 'returns all non hidden questions' do
      subject.map{ |q| q.first }.should == ['Reference question 1']
    end

    it 'returns question summary_type' do
      subject.first[1].should == :list
    end

    it 'returns application answers to question - skip hidden answers' do
      subject.first[2].map(&:value).should == ['Answer RQ1-1']
    end

    it 'returns all answers to question' do
      subject.first[3].map(&:value).should == ['Answer RQ1-1', 'Answer RQ1-3']
    end
  end

  describe 'number_of_references' do
    subject { summary.number_of_references }
    it { should == 2 }
  end
end

