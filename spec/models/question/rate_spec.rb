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

    it 'marks question as required' do
      element.stub(required: required = double('required'))
      subject[1][:required].should == required
    end
  end

  describe 'self.model_name' do
    subject { Question::Rate.model_name }

    it { should == Question.model_name }
  end
end

