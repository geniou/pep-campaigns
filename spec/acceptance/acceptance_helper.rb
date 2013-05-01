module AcceptanceHelpers

  def fill_in_contact_details
    fill_in 'Vorname', with: "Some"
    fill_in 'Nachname', with: "Person"
    fill_in 'E-Mail Adresse', with: "email@example.com"
  end
end
