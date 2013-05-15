class Question < ActiveRecord::Base

  attr_accessible :text, :for, :type, :options, :position, :required, :hint

  belongs_to :campaign
  has_many :answers, dependent: :destroy
  scope :orders, order(:position)

  serialize :options, Array

  def input_element
    [field_name, {
      label:      text,
      as:         input_type,
      collection: options,
      required:   required,
      hint:       hint
    } ]
  end

  def input_valid?(value)
    !value.nil? || !required
  end

  def self.types
    {
      I18n.t("question.type.simple_text")  => Question::SimpleText,
      I18n.t("question.type.text")         => Question::Text,
      I18n.t("question.type.rate")         => Question::Rate,
      I18n.t("question.type.select")       => Question::Select,
      I18n.t("question.type.boolean")      => Question::Boolean,
    }
  end

  def self.fors
    [:applicant, :application, :referee, :reference].inject({}) do |h, f|
      h[I18n.t("question.for.#{f}")] = f
      h
    end
  end
end
