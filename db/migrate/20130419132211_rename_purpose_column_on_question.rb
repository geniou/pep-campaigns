class RenamePurposeColumnOnQuestion < ActiveRecord::Migration
  def up
    add_column :questions, :for, :string, null: true
    Question.all.each do |question|
      question.update_attribute(:for, question.for_application ? :application : :reference)
    end
    change_column :questions, :for, :string, null: false
    remove_column :questions, :for_application
  end

  def down
    add_column :questions, :for_application, :boolean, null: true
    Question.all.each do |question|
      question.update_attribute(:for_application, question.for_application == 'application')
    end
    change_column :questions, :for_application, :boolean, null: false
    remove_column :questions, :for
  end
end
