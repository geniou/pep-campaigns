require 'spec_helper'

describe Export::Campaign do

  describe 'data' do
    subject { described_class.new(campaign).data([]) }
    let(:campaign) { create(:campaign) }

    let(:application_1) do
      contact = create(:applicant_contact, first_name: 'FN1', last_name: 'LN1', email: 'EM1')
      create(:application, campaign: campaign, contact: contact) do |application|
        create(:reference, application: application)
      end
    end
    let(:application_2) do
      contact = create(:applicant_contact, first_name: 'FN2', last_name: 'LN2', email: 'EM2')
      create(:application, campaign: campaign, contact: contact)
    end

    before do
      create(:text_question, campaign: campaign, for: :applicant, text: 'Applicant question',
             answer: 'Foo', application: application_1)
      create(:text_question, campaign: campaign, for: :application, text: 'Application question',
             answer: 'Bar', application: application_1)

      Rails.application.routes.url_helpers.should_receive(:summary_url)
        .with(application_1.summary_key).and_return('summary_1_url')
      Rails.application.routes.url_helpers.should_receive(:admin_application_summary_url)
        .with(application_1.id).and_return('admin_summary_1_url')
      Rails.application.routes.url_helpers.should_receive(:summary_url)
        .with(application_2.summary_key).and_return('summary_2_url')
      Rails.application.routes.url_helpers.should_receive(:admin_application_summary_url)
        .with(application_2.id).and_return('admin_summary_2_url')
    end

    it 'returns header' do
      subject.first.should == ['Vorname', 'Nachname', 'E-Mail',
                               'Applicant question', 'Application question',
                               'Referenzen', 'Fertig', 'öffentliche Auswertung',
                               'interne Auswertung']
    end

    it 'contains all contacts' do
      values_at('Vorname').should == ['FN1', 'FN2']
      values_at('Nachname').should == ['LN1', 'LN2']
      values_at('E-Mail').should == ['EM1', 'EM2']
    end

    it 'contains answers to applicant questions' do
      values_at('Applicant question').should == ['Foo', '']
    end

    it 'contains answers to application questions' do
      values_at('Application question').should == ['Bar', '']
    end

    it 'contains number of references' do
      values_at('Referenzen').should == [1, 0]
    end

    it 'contains if application is complete' do
      values_at('Fertig').should == [false, false]
    end

    it 'contains public summary path' do
      values_at('öffentliche Auswertung').should == ['summary_1_url', 'summary_2_url']
    end

    it 'contains internal summary path' do
      values_at('interne Auswertung').should == ['admin_summary_1_url', 'admin_summary_2_url']
    end
  end

  def values_at(name)
    subject[1..-1].map{ |row| row[subject[0].index(name)] }
  end
end
