class FixContactType < ActiveRecord::Migration
  def up
    Reference.all.each do |reference|
      contact = Contact.find(reference.contact_id)
      unless contact.is_a? Contact::Referee
        contact.update_attribute(:type, Contact::Referee)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
