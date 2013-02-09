class AddAnswers < ActiveRecord::Migration
  def up
    create_table :answers do |t|
      t.references :application
      t.references :reference
      t.string :type, null:false
      t.text :text
    end
  end

  def down
    drop_table :answers
  end
end
