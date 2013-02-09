class Question < ActiveRecord::Base
  attr_accessible :text

  belongs_to :campaign
end
