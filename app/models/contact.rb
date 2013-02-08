class Contact < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :applications
  has_many :references

end
