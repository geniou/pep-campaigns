class AddPurposeToQuestion < ActiveRecord::Migration
  def up
    add_column :questions, :for_application, :boolean
    Question.all.each do |question|
      question.update_attribute(:for_application, question.type == 'Question::Application')
    end
    change_column :questions, :for_application, :boolean, null: false
  end

  def down
    remove_column :questions, :for_application
  end
end
