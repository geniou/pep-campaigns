require 'spec_helper'

describe UserMailer do

  describe "deliver_references_received_mail" do

    subject do
      UserMailer.references_received_mail(application).deliver
      ActionMailer::Base.deliveries.first
    end

    let(:contact) do
      double('contact',
             email: 'eMail',
             attributes: {
               first_name: 'First Name',
               last_name: 'Last Name'
             }
            )
    end
    let(:campaign) do
      double('campaign',
             references_received_mail_from: 'a@example.com',
             references_received_mail_subject: 'Subject',
             references_received_mail_text: 'Hallo %{first_name}, %{last_name}'
            )
    end
    let(:application) do
      double('application', contact: contact, campaign: campaign)
    end

    before do
      ActionMailer::Base.deliveries = []
    end

    it "sends one mail" do
      subject
      ActionMailer::Base.deliveries.size.should == 1
    end

    it 'sets sender' do
      subject.from.first.should == campaign.references_received_mail_from
    end

    it 'sets subject' do
      subject.subject.should == campaign.references_received_mail_subject
    end

    it "sends a mail to the contact" do
      subject.to.first.should == contact.email
    end

    it 'includes contact name into mail' do
      subject.body.encoded.should match campaign.references_received_mail_text % contact.attributes
    end
  end
end
