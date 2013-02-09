class AddNameToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :name, :string, null: false
  end
end
