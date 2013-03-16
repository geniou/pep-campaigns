class AddIntroductoryTextForRefereesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :referee_introduction_text, :text
  end
end
