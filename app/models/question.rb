class Question < ActiveRecord::Base
  attr_accessible :text, :for_application, :type, :options

  belongs_to :campaign
  has_many :answers, dependent: :destroy

  serialize :options, Array

  def input_element
    raise NotImplementedError, "#{self.class}#input_element not implemented"
  end
end
