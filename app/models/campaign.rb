require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId
  has_many :questions
  has_many :applications
  has_many :applicant_questions,
    -> { where(for: :applicant).order(:position) },
    class_name: 'Question'
  has_many :application_questions,
    -> { where(for: :application).order(:position) },
    class_name: 'Question'
  has_many :referee_questions,
    -> { where(for: :referee).order(:position) },
    class_name: 'Question'
  has_many :reference_questions,
    -> { where(for: :reference).order(:position) },
    class_name: 'Question'

  validates_presence_of :name
  validates :required_reference_count, numericality: { only_integer: true, greater_than: 0 }

  def to_param
    hashed_id
  end

  def references_received_mail?
    !references_received_mail_from.blank? &&
      !references_received_mail_subject.blank? &&
      !references_received_mail_text.blank?
  end
end
