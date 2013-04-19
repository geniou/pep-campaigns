module ContactsHelper

  def contact_appearances(contact)
    appearances = []
    appearances_applications!(appearances, contact)
    appearances_refereneces!(appearances, contact)
    appearances.join(', ').html_safe
  end

  private

  def appearances_applications!(appearances, contact)
    contact.applications.each do |application|
      link = link_to(application.campaign.name, admin_application_path(application))
      appearances << "#{link} (Antrag)"
    end
  end

  def appearances_refereneces!(appearances, contact)
    contact.references.each do |reference|
      link = link_to(reference.campaign.name, admin_reference_path(reference))
      appearances << "#{link} (Referenz)"
    end
  end
end
