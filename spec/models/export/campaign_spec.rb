require 'spec_helper'

describe Export::Campaign do

  describe 'data' do
    subject { described_class.new(campaign).data([]) }
    let(:campaign) do
      double('campaign',
             applications: [ application_1, application_2 ],
             application_questions: ['foo'],
            )
    end
    let(:application_1) do
      double('application_1',
             id: 'id1',
             contact: contact_1,
             application_answers?: true,
             references: ['foo'],
             complete?: false,
             summary_key: 'key1'
            )
    end
    let(:contact_1) do
      double('contact_1',
             first_name: 'FN1',
             last_name: 'LN1',
             email: 'EM1',
            )
    end
    let(:application_2) do
      double('application_2',
             id: 'id2',
             contact: contact_2,
             application_answers?: false,
             references: [],
             complete?: true,
             summary_key: 'key2'
            )
    end
    let(:contact_2) do
      double('contact_2',
             first_name: 'FN2',
             last_name: 'LN2',
             email: 'EM2',
            )
    end
    before do
      Rails.application.routes.url_helpers.should_receive(:summary_url)
        .with('key1').and_return('summary_1_url')
      Rails.application.routes.url_helpers.should_receive(:admin_application_summary_url)
        .with('id1').and_return('admin_summary_1_url')
      Rails.application.routes.url_helpers.should_receive(:summary_url)
        .with('key2').and_return('summary_2_url')
      Rails.application.routes.url_helpers.should_receive(:admin_application_summary_url)
        .with('id2').and_return('admin_summary_2_url')
    end

    it 'returns header' do
      subject.first.should == ['Vorname', 'Nachname', 'E-Mail', 'Antworten', 'Referenzen',
                               'Fertig', 'öffentliche Auswertung', 'interne Auswertung']
    end

    it 'contains all contacts' do
      subject[1..-1].map { |c| c[0..2].join(' ') }.should =~ ['FN1 LN1 EM1', 'FN2 LN2 EM2']
    end

    it 'contains if personal answers are there' do
      rows_at_column(3).should =~ [true, false]
    end

    it 'contains number of references' do
      rows_at_column(4).should =~ [1, 0]
    end

    it 'contains if application is complete' do
      rows_at_column(5).should =~ [false, true]
    end

    it 'contains public summary path' do
      rows_at_column(6).should =~ ['summary_1_url', 'summary_2_url']
    end

    it 'contains internal summary path' do
      rows_at_column(7).should =~ ['admin_summary_1_url', 'admin_summary_2_url']
    end
  end

  def rows_at_column(column)
    subject[1..-1].map { |c| c[column] }
  end
end
