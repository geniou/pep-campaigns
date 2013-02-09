class AddCampaignQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :question_text
    change_table :questions do |t|
      t.references :campaign
      t.string :type, null: false
      t.text :text
    end
  end

  def down
    Question.delete_all
    remove_column :questions, :campaign_id
    remove_column :questions, :type
    add_column :questions, :question_text, :text
  end
end
