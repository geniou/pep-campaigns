class Question < ActiveRecord::Base
  attr_accessible :text, :for_application, :type, :options

  belongs_to :campaign

  serialize :options, Array

  def input_element
    raise NotImplementedError, "#{self.class}#input_element not implemented"
  end
end
