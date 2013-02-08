class Application < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :contact
  belongs_to :campaign

end
