class AddPasswordToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :password_hash, :string
    add_column :contacts, :password_salt, :string
  end
end
