module AcceptanceHelpers

  def fill_in_contact_details
    fill_in 'contact_first_name', :with => "Some"
    fill_in 'contact_last_name', :with => "Person"
    fill_in 'contact_organisation', :with => "Some organisation"
    fill_in 'contact_email', :with => "email@example.com"
    fill_in 'contact_website', :with => "http://website.com"
    fill_in 'contact_street_name', :with => "A strasse"
    fill_in 'contact_house_number', :with => "123"
    select "1980", :from => 'contact_birthdate_1i'
    select "January", :from => 'contact_birthdate_2i'
    select "1", :from => 'contact_birthdate_3i'
    choose 'contact_sex_m'
    fill_in 'contact_nationality', :with => 'French'
  end

end
