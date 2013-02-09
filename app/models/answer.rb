class Answer < ActiveRecord::Base
  attr_accessible :text, :question

  belongs_to :question

end
