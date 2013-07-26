require 'hashed_id'

class Reference < ActiveRecord::Base
  include HashedId

  delegate :referee_questions, :reference_questions, to: :campaign

  belongs_to :contact, class_name: Contact::Referee, dependent: :destroy
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  belongs_to :application
  has_many :answers
  has_many :referee_answers,
    -> { includes(:question).where("questions.for = 'referee'").references(:question) },
    class_name: Answer
  has_many :reference_answers,
    -> { includes(:question).where("questions.for = 'reference'").references(:question) },
    class_name: Answer
  accepts_nested_attributes_for :referee_answers, :reference_answers

  validates_associated :contact, :referee_answers, :reference_answers
  validates_presence_of :campaign, :application

  def to_param
    hashed_id
  end
end
