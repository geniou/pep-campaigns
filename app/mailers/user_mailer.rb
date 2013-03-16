class UserMailer < ActionMailer::Base
  default from: "pep@example.com"

  def references_received_mail(application)
    @application = application
    @contact = application.contact
    mail(:to => @contact.email, :subject => "All required references received!")
  end

end
