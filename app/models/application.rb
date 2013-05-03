require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name, :contact_attributes, :applicant_answers_attributes,
    :application_answers_attributes

  delegate :application_questions, :applicant_questions,
   :referee_questions, :reference_questions, to: :campaign

  belongs_to :contact, class_name: Contact::Applicant
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

  def application_answers?
    campaign.application_questions.count == application_answers.count
  end

  def required_references?
    references.size >= campaign.required_reference_count
  end

  def references_received_mail?
    references.size == campaign.required_reference_count
  end

  def complete?
    application_answers? && required_references?
  end
end
