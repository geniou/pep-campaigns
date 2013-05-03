require 'spec_helper'

describe Question::Select do

  describe 'field_name' do
    subject { element.field_name }
    let(:element) { Question::Select.new }

    it { should == :text_value }
  end

  describe 'input_element' do
    subject { element.input_element }
    let(:element) { Question::Select.new }

    it 'returns string_value as input name' do
      subject.first.should == :text_value
    end

    it 'returns radio as type' do
      subject[1][:as].should == :radio
    end

    it 'returns question text as label' do
      element.stub(text: 'The question')
      subject[1][:label].should == 'The question'
    end

    it 'returns options as possible answers' do
      element.stub(options: options = double)
      subject[1][:collection].should == options
    end

    it 'marks question as required' do
      element.stub(required: required = double('required'))
      subject[1][:required].should == required
    end
  end

  describe 'self.model_name' do
    subject { Question::Select.model_name }

    it { should == Question.model_name }
  end

  describe 'input_valid?' do
    subject { question.input_valid?(value) }
    let(:question) { Question::Boolean.new }
    before { question.stub(required: required) }

    context 'value empty, not required' do
      let(:value) { nil }
      let(:required) { false }
      it { should be_true }
    end

    context 'empty value, required' do
      let(:value) { nil }
      let(:required) { true }
      it { should be_false }
    end

    context 'value, required' do
      let(:value) { 'Foo' }
      let(:required) { true }
      it { should be_true }
    end
  end

  describe 'summary_type' do
    subject { Question::Select.new.summary_type }

    it { should == :key_value }
  end

  describe 'summary' do
    subject { question.summary(Answer.all) }
    let(:question) { create(:select_question, for: :application, required: false) }
    before do
      create(:answer, question: question, text_value: 'Foo')
      create(:answer, question: question, text_value: 'Bar')
      create(:answer, question: question, text_value: 'Foo')
      create(:answer, question: question, text_value: nil)
    end

    it { should == [['Foo', 2], ['Bar', 1]] }
  end
end
