class Reference < ActiveRecord::Base

  include HashedId

  # attr_accessible :title, :body

  belongs_to :contact
  belongs_to :campaign

end
