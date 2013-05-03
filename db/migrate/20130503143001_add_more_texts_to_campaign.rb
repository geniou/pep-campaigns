class AddMoreTextsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :application_introduction_text, :text
    add_column :campaigns, :application_success_text, :text
    add_column :campaigns, :reference_success_text, :text
  end
end
