class Answer < ActiveRecord::Base
  attr_accessible :text_value, :numeric_value, :boolean_value, :question_id

  belongs_to :question

  validate :value_exists?

  def value
    text_value || numeric_value || boolean_value
  end

  protected

  def value_exists?
    errors.add(:base, "Value needed") unless value
  end
end
