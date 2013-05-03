class Contact < ActiveRecord::Base

  attr_protected :id

  has_many :references

  validates_presence_of :first_name, :last_name, :email

  def name
    [ last_name, first_name ].join(", ")
  end
end
