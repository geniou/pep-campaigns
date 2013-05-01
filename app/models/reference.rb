require 'hashed_id'

class Reference < ActiveRecord::Base

  include HashedId

  attr_accessible :contact_attributes, :referee_answers, :reference_answers_attributes

  belongs_to :contact
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  belongs_to :application
  has_many :answers
  has_many :referee_answers, class_name: Answer
  has_many :reference_answers, class_name: Answer
  accepts_nested_attributes_for :referee_answers, :reference_answers

  validates_associated :answers
  validates_associated :contact
  validates_presence_of :campaign
  validates_presence_of :application

  def to_param
    hashed_id
  end

  def questions
    campaign.reference_questions.ordered
  end
end
