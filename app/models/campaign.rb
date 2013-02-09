require 'hashed_id'

class Campaign < ActiveRecord::Base

  include HashedId

  # attr_accessible :title, :body

  def to_param
    hashed_id
  end

end
