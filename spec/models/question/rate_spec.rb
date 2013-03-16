require 'spec_helper'

describe Question::Rate do

  describe 'input_element' do
    subject { element.input_element }
    let(:element) { Question::Rate.new }

    it 'returns numeric_value as input name' do
      subject.first.should == :numeric_value
    end

    it 'returns radio as type' do
      subject[1][:as].should == :radio
    end

    it 'returns question text as label' do
      element.stub(text: 'The question')
      subject[1][:label].should == 'The question'
    end
  end
end

