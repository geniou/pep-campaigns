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
      subject[1..-1].map { |c| c[0..2].join(' ') }.should =~ ['FN1 LN1 EM1', 'FN2 LN2 EM2']
    end

    it 'contains answers to applicant questions' do
      rows_at_column(3).should =~ ['Foo', ""]
    end

    it 'contains answers to application questions' do
      rows_at_column(4).should =~ ['Bar', ""]
    end

    it 'contains number of references' do
      rows_at_column(5).should =~ [1, 0]
    end

    it 'contains if application is complete' do
      rows_at_column(6).should =~ [false, false]
    end

    it 'contains public summary path' do
      rows_at_column(7).should =~ ['summary_1_url', 'summary_2_url']
    end

    it 'contains internal summary path' do
      rows_at_column(8).should =~ ['admin_summary_1_url', 'admin_summary_2_url']
    end
  end

  def rows_at_column(column)
    subject[1..-1].map { |c| c[column] }
  end
end
