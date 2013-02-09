class Reference < ActiveRecord::Base

  include HashedId

  # attr_accessible :title, :body

  belongs_to :contact
  belongs_to :campaign
  belongs_to :application

  validates_presence_of :application
  validates_presence_of :campaign
  validates_presence_of :contact

  def to_param
    hashed_id
  end

end
