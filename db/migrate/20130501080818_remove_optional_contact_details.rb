class RemoveOptionalContactDetails < ActiveRecord::Migration

  def up
    remove_column :contacts, :organisation
    remove_column :contacts, :website
    remove_column :contacts, :street_name
    remove_column :contacts, :house_number
    remove_column :contacts, :city
    remove_column :contacts, :postcode
    remove_column :contacts, :skype_name
    remove_column :contacts, :telephone_number
    remove_column :contacts, :birthdate
    remove_column :contacts, :sex
    remove_column :contacts, :nationality
  end

  def down
    add_column :contacts, :organisation, :string
    add_column :contacts, :website, :string
    add_column :contacts, :street_name, :string
    add_column :contacts, :house_number, :integer
    add_column :contacts, :city, :string
    add_column :contacts, :postcode, :integer
    add_column :contacts, :skype_name, :string
    add_column :contacts, :telephone_number, :string
    add_column :contacts, :birthdate, :date
    add_column :contacts, :sex, :string
    add_column :contacts, :nationality, :string
  end
end
