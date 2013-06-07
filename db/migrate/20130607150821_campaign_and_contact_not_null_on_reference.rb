class CampaignAndContactNotNullOnReference < ActiveRecord::Migration
  def up
    change_column :references, :contact_id, :integer, null: false
    change_column :references, :campaign_id, :integer, null: false
  end

  def down
    change_column :references, :contact_id, :integer, null: true
    change_column :references, :campaign_id, :integer, null: true
  end
end
