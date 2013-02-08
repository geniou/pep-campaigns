class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :contact
      t.references :campaign
      t.timestamps
    end
  end
end
