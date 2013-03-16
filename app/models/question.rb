class Question < ActiveRecord::Base
  attr_accessible :text, :for_application, :type

  belongs_to :campaign

  def input_element
    raise NotImplementedError, "#{self.class}#input_element not implemented"
  end
end
