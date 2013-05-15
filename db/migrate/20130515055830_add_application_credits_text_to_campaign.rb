class AddApplicationCreditsTextToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :application_credits_text, :text, null: true
  end
end
