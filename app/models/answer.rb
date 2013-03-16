class Answer < ActiveRecord::Base
  attr_accessible :text_value, :numeric_value, :boolean_value, :question_id

  belongs_to :question

  def value
    text_value || numeric_value || boolean_value
  end
end
