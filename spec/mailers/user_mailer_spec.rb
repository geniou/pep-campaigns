require 'spec_helper'

describe UserMailer do

  describe "deliver_references_received_mail" do

    before :each do
      ActionMailer::Base.deliveries = []
      @application = FactoryGirl.create(:application)
      @contact = @application.contact
    end

    it "should send a mail to the contact" do
      UserMailer.references_received_mail(@application).deliver

      ActionMailer::Base.deliveries.size.should == 1
      mail = ActionMailer::Base.deliveries.first
      mail.to.first.should == @contact.email
      mail.body.encoded.should match("#{@contact.first_name} #{@contact.last_name}")
    end

  end

end
