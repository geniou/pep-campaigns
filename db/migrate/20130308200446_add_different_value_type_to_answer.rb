class AddDifferentValueTypeToAnswer < ActiveRecord::Migration
  def up
    rename_column :answers, :text, :text_value
    add_column :answers, :numeric_value, :numeric
    add_column :answers, :boolean_value, :boolean
  end

  def down
    remove_column :answers, :boolean_value
    remove_column :answers, :numeric_value
    rename_column :answers, :text_value, :text
  end
end
