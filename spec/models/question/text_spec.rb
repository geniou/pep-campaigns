require 'spec_helper'

describe Question::Text do

  describe 'field_name' do
    subject { question.field_name }
    let(:question) { Question::Text.new }

    it { should == :text_value }
  end

  describe 'input_element' do
    subject { question.input_element }
    let(:question) { Question::Text.new }

    it 'returns text_value as input name' do
      subject.first.should == :text_value
    end

    it 'returns text as type' do
      subject[1][:as].should == :text
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
    subject { Question::Text.model_name }

    it { should == Question.model_name }
  end

  describe 'valid?' do
    subject { question.input_valid?(value) }
    let(:question) { Question::Text.new }
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
end
