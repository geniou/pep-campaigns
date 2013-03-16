class AddOptionsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :options, :string, null: true
  end
end
