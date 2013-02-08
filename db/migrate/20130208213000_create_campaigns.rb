class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.boolean :open_to_applicants, :default => true
      t.boolean :open_to_referees, :default => true
      t.timestamps
    end
  end
end
