class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :contact
      t.references :campaign
      t.timestamps
    end
  end
end
