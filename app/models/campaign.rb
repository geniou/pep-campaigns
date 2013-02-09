require 'hashed_id'

class Campaign < ActiveRecord::Base

  include HashedId

  # attr_accessible :title, :body
end
