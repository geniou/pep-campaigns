class RemoveApplicationName < ActiveRecord::Migration
  def up
    remove_column :applications, :name
  end

  def down
    remove_column :applications, :name, :string
  end
end
