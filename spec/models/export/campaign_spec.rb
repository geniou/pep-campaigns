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
             name: 'Contact 1',
             email: 'contact1@example.com'
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
             name: 'Contact 2',
             email: 'contact2@example.com'
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
      subject.first.should == ['Kontakt', 'Antworten', 'Referenzen', 'Fertig',
                               'öffentliche Auswertung', 'interne Auswertung']
    end

    it 'contains all contacts' do
      rows_at_column(0).should =~ ['Contact 1', 'Contact 2']
    end

    it 'contains if personal answers are there' do
      rows_at_column(1).should =~ [true, false]
    end

    it 'contains number of references' do
      rows_at_column(2).should =~ [1, 0]
    end

    it 'contains if application is complete' do
      rows_at_column(3).should =~ [false, true]
    end

    it 'contains public summary path' do
      rows_at_column(4).should =~ ['summary_1_url', 'summary_2_url']
    end

    it 'contains internal summary path' do
      rows_at_column(5).should =~ ['admin_summary_1_url', 'admin_summary_2_url']
    end
  end

  def rows_at_column(column)
    subject[1..-1].map { |c| c[column] }
  end
end
