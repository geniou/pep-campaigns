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

  validates_associated :answers
  validates_associated :contact
  validates_presence_of :campaign

  def to_param
    hashed_id
  end

  def questions
    campaign.application_questions.ordered
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
end
