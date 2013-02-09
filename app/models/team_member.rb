class TeamMember < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :application

end
