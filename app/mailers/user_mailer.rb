class UserMailer < ActionMailer::Base
  def references_received_mail(application)
    mail(
      from:    application.campaign.references_received_mail_from,
      to:      application.contact.email,
      subject: application.campaign.references_received_mail_subject,
      body:    application.campaign.references_received_mail_text % application.contact.attributes
    )
  end
end
