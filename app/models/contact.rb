class Contact < ActiveRecord::Base

  attr_protected :id

  has_many :applications
  has_many :references

end
