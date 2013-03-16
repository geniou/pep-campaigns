require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name, :contact_attributes, :answers_attributes

  belongs_to :contact
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  has_many :references
  has_many :team_members
  has_many :answers, conditions: "application_id IS NOT NULL"
  accepts_nested_attributes_for :answers

  validates_presence_of :contact
  validates_presence_of :campaign
  validate :all_questions_answered

  def to_param
    hashed_id
  end

  def questions
    campaign.application_questions
  end

  def complete
    references.size >= campaign.required_reference_count
  end

  def self.complete
    Application.all.select { |a| a.complete }
  end

  def self.incomplete
    Application.all.select { |a| !a.complete }
  end

protected

  def all_questions_answered
    if (answers.size != questions.size)
      errors.add(:answers, "All questions must be answered")
    end
  end

end
