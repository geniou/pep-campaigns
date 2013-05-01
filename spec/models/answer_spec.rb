require 'spec_helper'

describe Answer do

  describe 'value' do
    subject { answer.value }
    let(:answer) do
      Answer.new(
        text_value: nil,
        numeric_value: nil,
        boolean_value: nil
      )
    end

    it 'returns text value' do
      answer.text_value = 'Text value'
      subject.should == 'Text value'
    end

    it 'returns numeric value' do
      answer.text_value = 1234
      subject.should == 1234
    end

    it 'returns boolean value' do
      answer.text_value = boolean = double('boolean')
      subject.should == boolean
    end
  end

  describe 'valid?' do
    subject { Answer.new }
    let(:question) { double('question', input_valid?: valid, field_name: :foo) }
    before { subject.stub(question: question) }

    context 'answer valid' do
      let(:valid) { true }
      it 'add no error' do
        subject.errors.should_not_receive(:add)
        subject.valid?
      end
    end

    context 'answer invalid' do
      let(:valid) { false }
      it 'adds error' do
        subject.errors.should_receive(:add)
        subject.valid?
      end
    end
  end
end
