class Answer < ActiveRecord::Base
  attr_accessible :text_value, :numeric_value, :boolean_value, :question_id

  belongs_to :question
  belongs_to :reference

  validate :value_exists?

  def value
    text_value || numeric_value || boolean_value
  end

  protected

  def value_exists?
    errors.add(question.field_name, I18n.t('answers.error.blank')) unless question.input_valid?(value)
  end
end
