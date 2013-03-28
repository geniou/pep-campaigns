class Question < ActiveRecord::Base
  attr_accessible :text, :for_application, :type, :options, :position

  belongs_to :campaign
  has_many :answers, dependent: :destroy
  scope :orders, order(:position)

  serialize :options, Array

  def input_element
    raise NotImplementedError, "#{self.class}#input_element not implemented"
  end
end
