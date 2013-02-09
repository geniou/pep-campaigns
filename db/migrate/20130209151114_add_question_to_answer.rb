class AddQuestionToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :question_id, :int
  end
end
