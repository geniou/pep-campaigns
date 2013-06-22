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

  describe 'summary_type' do
    subject { Question::Boolean.new.summary_type }

    it { should == :percentage }
  end

  describe 'summary' do
    subject { question.summary(answers) }
    let(:question) { create(:boolean_question, for: :application, required: false) }
    let(:answers) { Answer }

    context 'with answers' do
      let!(:positive_answer) { create(:answer, question: question, boolean_value: true) }
      before do
        create(:answer, question: question, boolean_value: false)
        create(:answer, question: question, boolean_value: nil)
      end

      it 'returns average value' do
        subject[:percentage].should == 50
      end

      it 'returns positive answers' do
        subject[:answers].should == [positive_answer]
      end
    end

    context 'without any answers' do
      it 'returns nil as average value' do
        subject[:percentage].should be_nil
      end
    end
  end

  describe 'formatted_value' do
    subject { question.formatted_value(value) }
    let(:question) { create(:boolean_question, for: :application, required: false) }

    describe 'true' do
      let(:value) { true }
      it { should == 'Ja' }
    end

    describe 'false' do
      let(:value) { false }
      it { should == 'Nein' }
    end
  end
end
