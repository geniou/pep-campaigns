class ContactDetailsRequired < ActiveRecord::Migration
  def up
    change_column :contacts, :first_name, :string, null: false
    change_column :contacts, :last_name, :string, null: false
    change_column :contacts, :email, :string, null: false
  end

  def down
    change_column :contacts, :first_name, :string, null: true
    change_column :contacts, :last_name, :string, null: true
    change_column :contacts, :email, :string, null: true
  end
end
