require 'spec_helper'

describe Question::Select do

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
end


