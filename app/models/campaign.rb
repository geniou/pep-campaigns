require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId

  attr_accessible :name, :applicant_introduction_text, :referee_introduction_text, :required_reference_count
  has_many :questions
  has_many :applications
  has_many :application_questions,
    class_name: 'Question',
    conditions: { for_application: true },
    order: :position
  has_many :reference_questions,
    class_name: 'Question',
    conditions: { for_application: false },
    order: :position

  validates_presence_of :name
  validates :required_reference_count, :numericality => { :only_integer => true, :greater_than => 0 }

  def to_param
    hashed_id
  end

  def self.open_to_applicants
    where(:open_to_applicants => true)
  end

  def self.open_to_referees
    where(:open_to_referees => true)
  end

  def self.only_open_to_referees
    where(:open_to_referees => true).where(:open_to_applicants => false)
  end

  def self.closed
    where(:open_to_referees => false).where(:open_to_applicants => false)
  end

end
