require 'hashed_id'

class Reference < ActiveRecord::Base

  include HashedId

  belongs_to :contact
  belongs_to :campaign
  belongs_to :application
  has_many :answers, class_name: 'Answer::Reference'

  validates_presence_of :contact
  validates_presence_of :campaign
  validate :all_questions_answered
  validates_presence_of :application

  def to_param
    hashed_id
  end

  def questions
    campaign.reference_questions
  end

protected

  def all_questions_answered
    if (answers.size != questions.size)
      errors.add(:answers, "All questions must be answered")
    end
  end

end
