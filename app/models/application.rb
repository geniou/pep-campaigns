require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name

  belongs_to :contact
  belongs_to :campaign
  has_many :references
  has_many :team_members
  has_many :answers, class_name: 'Answer::Application'

  validates_presence_of :campaign
  validates_presence_of :contact
  validate :all_questions_answered

  def to_param
    hashed_id
  end

  def self.complete
    Application.all.select { |a| a.references.size >= PEPCampaigns::REQUIRED_REFERENCES }
  end

  def self.incomplete
    Application.all.select { |a| a.references.size < PEPCampaigns::REQUIRED_REFERENCES }
  end

private

  def all_questions_answered
    if (answers.size != campaign.application_questions.size)
      errors.add(:answers, "All questions must be answered")
    end
  end

end
