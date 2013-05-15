require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId

  attr_accessible :name, :applicant_introduction_text, :application_introduction_text,
    :application_credits_text, :application_success_text, :referee_introduction_text,
    :reference_success_text, :required_reference_count, :open_to_applicants, :open_to_referees
  has_many :questions
  has_many :applications
  has_many :applicant_questions,
    class_name: 'Question',
    conditions: { for: :applicant },
    order: :position
  has_many :application_questions,
    class_name: 'Question',
    conditions: { for: :application },
    order: :position
  has_many :referee_questions,
    class_name: 'Question',
    conditions: { for: :referee },
    order: :position
  has_many :reference_questions,
    class_name: 'Question',
    conditions: { for: :reference },
    order: :position

  validates_presence_of :name
  validates :required_reference_count, numericality: { only_integer: true, greater_than: 0 }

  def to_param
    hashed_id
  end
end
