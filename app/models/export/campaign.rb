class Export::Campaign < Export::Base

  attr_accessor :campaign

  def initialize(campaign)
    @campaign = campaign
    # TODO put somewhere else
    Rails.application.routes.default_url_options[:host] = Rails.env.production? ? 'still-shore-6191.herokuapp.com' : 'localhost:3000'
  end

  def data(export)
    export << [].tap do |head|
      head << 'Kontakt'
      head << 'Antworten' if @campaign.application_questions.any?
      head << 'Referenzen'
      head << 'Fertig'
      head << 'öffentliche Auswertung'
      head << 'interne Auswertung'
    end

    @campaign.applications.each do |application|
      export <<  [].tap do |row|
        row << application.contact.name
        row << application.application_answers? if @campaign.application_questions.any?
        row << application.references.size
        row << application.complete?
        row << Rails.application.routes.url_helpers.summary_url(application.summary_key)
        row << Rails.application.routes.url_helpers.admin_application_summary_url(application.id)
      end
    end

    export
  end
end
