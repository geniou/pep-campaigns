# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default from: "PEP Deutschland <pep@example.com>"

  def references_received_mail(application)
    @application = application
    @contact = application.contact
    mail(:to => @contact.email, :subject => "Alle Referenzen für Deine Bewerbung sind vorhanden!")
  end

end
