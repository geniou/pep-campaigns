class Contact < ActiveRecord::Base

  attr_protected :id

  has_many :applications
  has_many :references

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :organisation
  validates_presence_of :email
  validates_presence_of :website
  validates_presence_of :street_name
  validates_presence_of :house_number
  validates_presence_of :birthdate
  validates_presence_of :sex
  validates_presence_of :nationality
  
  def name
    [ last_name, first_name ].join(", ")
  end

end
