require 'spec_helper'

describe Question do

  describe 'self.types' do
    subject { Question.types }
    it { should == {
      'Text'      => Question::Text,
      'Bewertung' => Question::Rate,
      'Auswahl'   => Question::Select,
      'Checkbox'  => Question::Boolean,
    } }
  end
end
