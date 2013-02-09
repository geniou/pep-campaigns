require 'hashed_id'

class Application < ActiveRecord::Base

  include HashedId

  attr_accessible :name

  belongs_to :contact
  belongs_to :campaign
  has_many :team_members

  def to_param
    hashed_id
  end

end
