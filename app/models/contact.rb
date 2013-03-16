class Contact < ActiveRecord::Base

  attr_protected :id

  has_many :applications
  has_many :references

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

=begin
  These fields are optional now. In a future version, would
  be great if they were configurable @see Case 46320811

  validates_presence_of :organisation
  validates_presence_of :website
  validates_presence_of :street_name
  validates_presence_of :house_number
  validates_presence_of :birthdate
  validates_presence_of :sex
  validates_presence_of :nationality
=end

  def address
    [ street_address, postcode, city ].compact.join(", ")
  end 
 
  def street_address
    [ house_number, street_name ].compact.join(" ")
  end

  def name
    [ last_name, first_name ].join(", ")
  end

end
