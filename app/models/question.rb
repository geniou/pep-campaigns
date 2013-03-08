class Question < ActiveRecord::Base
  attr_accessible :text, :for_application

  belongs_to :campaign
end
