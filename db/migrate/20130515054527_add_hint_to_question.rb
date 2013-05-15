class AddHintToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :hint, :string, null: true
  end
end
