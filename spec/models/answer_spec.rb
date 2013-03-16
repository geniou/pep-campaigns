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
end
