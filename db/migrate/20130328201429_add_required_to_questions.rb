class AddRequiredToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :required, :boolean, null: false, default: true
  end
end
