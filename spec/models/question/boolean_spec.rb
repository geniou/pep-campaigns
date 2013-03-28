require 'spec_helper'

describe Question::Boolean do

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
  end

  describe 'self.model_name' do
    subject { Question::Boolean.model_name }

    it { should == Question.model_name }
  end
end
