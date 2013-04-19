require 'spec_helper'

describe ContactsHelper do

  describe 'contact_appearances' do
    subject { Capybara.string(helper.contact_appearances(contact)) }
    let(:contact) { double('contact', applications: applications, references: references) }
    let(:applications) { [] }
    let(:references) { [] }
    let(:campaign) { double('campaign', name: 'The campaign') }

    context 'application contact' do
      let(:applications) { [application] }
      let(:application) { double('application', campaign: campaign) }
      before do
        helper.should_receive(:admin_application_path)
          .with(application).and_return('application_link')
      end

      it 'returns link to campaign' do
        subject.should have_selector('a[href="application_link"]', text: 'The campaign')
      end

      it 'returns marks link as allplication' do
        subject.should have_content('Antrag')
      end
    end

    context 'reference contact' do
      let(:references) { [reference] }
      let(:reference) { double('reference', campaign: campaign) }
      before do
        helper.should_receive(:admin_reference_path)
          .with(reference).and_return('reference_link')
      end

      it 'returns link to campaign' do
        subject.should have_selector('a[href="reference_link"]', text: 'The campaign')
      end

      it 'returns marks link as allplication' do
        subject.should have_content('Referenz')
      end
    end
  end
end
