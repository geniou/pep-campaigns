require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name

  belongs_to :contact
  belongs_to :campaign
  has_many :references
  has_many :team_members

  validates_presence_of :campaign
  validates_presence_of :contact

  def to_param
    hashed_id
  end

  def self.complete
    Application.all.select { |a| a.references.size >= PEPCampaigns::REQUIRED_REFERENCES }
  end

  def self.incomplete
    Application.all.select { |a| a.references.size < PEPCampaigns::REQUIRED_REFERENCES }
  end

end
