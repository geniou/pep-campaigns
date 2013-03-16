class AddRequiredNumberOfReferencesToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :required_reference_count, :integer, :default => 10
  end
end
