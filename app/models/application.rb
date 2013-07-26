require 'hashed_id'

class Application < ActiveRecord::Base
  include HashedId

  delegate :application_questions, :applicant_questions,
   :referee_questions, :reference_questions, to: :campaign

  belongs_to :contact, class_name: Contact::Applicant, dependent: :destroy
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  has_many :references, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :applicant_answers,
    -> { includes(:question).where("questions.for = 'applicant'").references(:question) },
    class_name: Answer
  has_many :application_answers,
    -> { includes(:question).where("questions.for = 'application'").references(:question) },
    class_name: Answer
  accepts_nested_attributes_for :applicant_answers, :application_answers

  validates_associated :answers, :contact
  validates_presence_of :campaign

  before_create :create_summary_key

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

  private

  def create_summary_key
    self.summary_key = SecureRandom.hex(5)
  end
end
