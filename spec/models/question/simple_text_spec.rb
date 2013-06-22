require 'spec_helper'

describe Question::SimpleText do

  describe 'field_name' do
    subject { question.field_name }
    let(:question) { Question::SimpleText.new }

    it { should == :text_value }
  end

  describe 'input_element' do
    subject { question.input_element }
    let(:question) { Question::SimpleText.new }

    it 'returns text_value as input name' do
      subject.first.should == :text_value
    end

    it 'returns string as type' do
      subject[1][:as].should == :string
    end

    it 'returns question text as label' do
      question.stub(text: 'The question')
      subject[1][:label].should == 'The question'
    end

    it 'marks question as required' do
      question.stub(required: required = double('required'))
      subject[1][:required].should == required
    end
  end

  describe 'self.model_name' do
    subject { Question::SimpleText.model_name }

    it { should == Question.model_name }
  end

  describe 'valid?' do
    subject { question.input_valid?(value) }
    let(:question) { Question::SimpleText.new }
    before { question.stub(required: required) }

    context 'value empty, not required' do
      let(:value) { '' }
      let(:required) { false }
      it { should be_true }
    end

    context 'empty value, required' do
      let(:value) { '' }
      let(:required) { true }
      it { should be_false }
    end

    context 'value, required' do
      let(:value) { 'foo' }
      let(:required) { true }
      it { should be_true }
    end
  end

  describe 'summary_type' do
    subject { Question::SimpleText.new.summary_type }

    it { should == :list }
  end

  describe 'summary' do
    subject { question.summary(Answer.all) }
    let(:question) { create(:simple_text_question, for: :application, required: false) }
    let!(:answer1) { create(:answer, question: question, text_value: 'Foo') }
    let!(:answer2) { create(:answer, question: question, text_value: 'Bar') }
    before do
      create(:answer, question: question, text_value: '')
    end

    it { should == [answer1, answer2] }
  end

  describe 'formatted_value' do
    subject { question.formatted_value(value) }
    let(:question) { create(:rate_question, for: :application) }
    let(:value) { double('value') }

    it 'returns value' do
      subject.should == value
    end
  end
end

