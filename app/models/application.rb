require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name, :contact_attributes, :applicant_answers_attributes,
    :application_answers_attributes

  belongs_to :contact
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  has_many :references
  has_many :team_members
  has_many :answers
  has_many :applicant_answers,   class_name: Answer, include: :question, conditions: [ "questions.for = 'applicant'" ]
  has_many :application_answers, class_name: Answer, include: :question, conditions: [ "questions.for = 'application'" ]
  accepts_nested_attributes_for :applicant_answers, :application_answers

  validates_associated :answers, :contact
  validates_presence_of :campaign

  def to_param
    hashed_id
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
