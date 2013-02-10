#-*- coding: utf-8 -*
module AcceptanceHelpers

  def fill_in_contact_details
    fill_in 'Vorname', with: "Some"
    fill_in 'Nachname', with: "Person"
    fill_in 'Organization', with: "Some organisation"
    fill_in 'E-Mail Adresse', with: "email@example.com"
    fill_in 'Webseite', with: "http://website.com"
    fill_in 'Straße', with: "A strasse"
    fill_in 'Hausnummer', with: "123"
    select 'm', :from => 'Geschlecht'
    fill_in 'Nationalität', with: 'French'
  end

end
