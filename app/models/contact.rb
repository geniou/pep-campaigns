class Contact < ActiveRecord::Base

  attr_protected :id

  has_many :applications
  has_many :references

  def name
    [ last_name, first_name ].join(", ")
  end

end
