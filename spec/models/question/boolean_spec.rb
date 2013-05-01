require 'spec_helper'

describe Question::Boolean do

  describe 'field_name' do
    subject { element.field_name }
    let(:element) { Question::Boolean.new }

    it { should == :boolean_value }
  end

  describe 'input_element' do
    subject { element.input_element }
    let(:element) { Question::Boolean.new }

    it 'returns text_value as input name' do
      subject.first.should == :boolean_value
    end

    it 'returns boolean as type' do
      subject[1][:as].should == :boolean
    end

    it 'returns question text as label' do
      element.stub(text: 'The question')
      subject[1][:label].should == 'The question'
    end

    it 'marks question as required' do
      element.stub(required: required = double('required'))
      subject[1][:required].should == required
    end
  end

  describe 'self.model_name' do
    subject { Question::Boolean.model_name }

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
      let(:value) { false }
      let(:required) { true }
      it { should be_true }
    end
  end
end
