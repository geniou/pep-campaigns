require 'hashed_id'

class Reference < ActiveRecord::Base

  include HashedId

  attr_accessible :contact_attributes, :answers_attributes

  belongs_to :contact
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  belongs_to :application
  has_many :answers, conditions: "reference_id IS NOT NULL"
  accepts_nested_attributes_for :answers

  validates_associated :answers
  validates_associated :contact
  validates_presence_of :campaign
  validates_presence_of :application

  def to_param
    hashed_id
  end

  def questions
    campaign.reference_questions
  end
end
