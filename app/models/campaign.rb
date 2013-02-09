require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId

  attr_accessible :name

  def to_param
    hashed_id
  end

  def self.open_to_applicants
    where(:open_to_applicants => true)
  end

  def self.open_to_referees
    where(:open_to_referees => true)
  end

  def self.only_open_to_referees
    where(:open_to_referees => true).where(:open_to_applicants => false)
  end

  def self.closed
    where(:open_to_referees => false).where(:open_to_applicants => false)
  end

end
