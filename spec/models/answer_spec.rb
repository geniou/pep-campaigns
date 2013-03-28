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
    before { subject.stub_chain(:question, required: required) }

    context 'question is required' do
      let(:required) { true }
      context 'with value' do
        before { subject.stub(value: double('value')) }
        it 'add no error' do
          subject.errors.should_not_receive(:add)
          subject.valid?
        end
      end
      context 'without value' do
        before { subject.stub(value: nil) }
        it 'add an error' do
          subject.errors.should_receive(:add)
          subject.valid?
        end
      end
    end

    context 'question is not required' do
      let(:required) { false }
      context 'with value' do
        before { subject.stub(value: double('value')) }
        it 'add no error' do
          subject.errors.should_not_receive(:add)
          subject.valid?
        end
      end
      context 'without value' do
        before { subject.stub(value: nil) }
        it 'add no error' do
          subject.errors.should_not_receive(:add)
          subject.valid?
        end
      end
    end
  end
end
