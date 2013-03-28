class Question < ActiveRecord::Base
  attr_accessible :text, :for_application, :type, :options, :position, :required

  belongs_to :campaign
  has_many :answers, dependent: :destroy
  scope :orders, order(:position)

  serialize :options, Array

  def input_element
    raise NotImplementedError, "#{self.class}#input_element not implemented"
  end

  def self.types
    {
      'Text'      => Question::Text,
      'Bewertung' => Question::Rate,
      'Auswahl'   => Question::Select,
      'Checkbox'  => Question::Boolean,
    }
  end
end
