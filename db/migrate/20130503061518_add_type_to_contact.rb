class AddTypeToContact < ActiveRecord::Migration
  def up
    add_column :contacts, :type, :string, default: 'Contact'
    Contact.all.each do |contact|
      contact.update_attribute(:type, contact.references.any? ? 'Contact::Referee' : 'Contact::Applicant')
    end
    change_column :contacts, :type, :string, nil: false
  end

  def down
    remove_column :contacts, :type
  end
end
