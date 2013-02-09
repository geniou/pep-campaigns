require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId

  attr_accessible :name
  has_many :questions
  has_many :application_questions, class_name: 'Question::Application'
  has_many :reference_questions,   class_name: 'Question::Reference'

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
