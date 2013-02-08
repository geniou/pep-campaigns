class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :organisation
      t.string :email
      t.string :website
      t.string :street_name
      t.integer :house_number
      t.string :city
      t.integer :postcode
      t.string :skype_name
      t.string :telephone_number
      t.date :birthdate
      t.string :sex
      t.string :nationality
       
      t.timestamps
    end
  end
end
