class AddSummaryKeyToApplication < ActiveRecord::Migration
  def up
    add_column :applications, :summary_key, :string
    Application.all.each do |application|
      application.update_attribute(:summary_key, SecureRandom.hex(5))
    end
    change_column :applications, :summary_key, :string, unique: false, null: false
  end

  def down
    remove_column :applications, :summary_key
  end
end
