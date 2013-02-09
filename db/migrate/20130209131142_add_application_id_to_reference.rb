class AddApplicationIdToReference < ActiveRecord::Migration
  def change
    add_column :references, :application_id, :int
  end
end
