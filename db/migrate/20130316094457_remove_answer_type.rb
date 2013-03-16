class RemoveAnswerType < ActiveRecord::Migration
  def up
    remove_column :answers, :type
  end

  def down
    add_column :answers, :type, :string, null: false
  end
end
