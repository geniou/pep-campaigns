require 'spec_helper'

describe Question do

  describe 'self.types' do
    subject { Question.types }
    it { should == {
      'Textzeile'         => Question::SimpleText,
      'Text (mehrzeilig)' => Question::Text,
      'Bewertung'         => Question::Rate,
      'Auswahl'           => Question::Select,
      'Checkbox'          => Question::Boolean,
    } }
  end
end
