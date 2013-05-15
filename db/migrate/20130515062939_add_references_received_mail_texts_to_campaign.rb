class AddReferencesReceivedMailTextsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :references_received_mail_from,    :string, null: true
    add_column :campaigns, :references_received_mail_subject, :string, null: true
    add_column :campaigns, :references_received_mail_text,    :text,   null: true
  end
end
