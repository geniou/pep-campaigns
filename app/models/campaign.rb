require 'hashed_id'

class Campaign < ActiveRecord::Base
  include HashedId

  attr_accessible :name

  def to_param
    hashed_id
  end

end
