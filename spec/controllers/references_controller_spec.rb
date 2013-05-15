require 'spec_helper'

describe ReferencesController do

  describe "new" do
    it "should render 404 for an invalid application hash" do
      Campaign.stub(find_by_hashed_id: double)
      Application.stub(find_by_hashed_id: nil)
      lambda {
        get :new, application_id: 'foo'
      }.should raise_error(ActionController::RoutingError)
    end

    it "should render 404 for an invalid campaign hash" do
      Campaign.stub(find_by_hashed_id: nil)
      Application.stub(find_by_hashed_id: double)
      lambda {
        get :new, campaign_id: 'foo'
      }.should raise_error(ActionController::RoutingError)
    end
  end

  describe "create" do

    before :each do
      ActionMailer::Base.deliveries = []

      @reference_contact = FactoryGirl.create(:contact)
      @application = FactoryGirl.create(:application)
      @params = { :campaign_id => @application.campaign.hashed_id,
                  :application_id => @application.hashed_id,
                  :reference => {
                    :contact_attributes => {
                      :email => @reference_contact.email,
                      :last_name => @reference_contact.last_name,
                      :first_name => @reference_contact.first_name
                    }
                  }
                }
    end

    def do_request(params = {})
      post :create, @params.update(params)
    end

    it "should create a new reference" do
      lambda {
        do_request
      }.should change(Reference, :count).by(1)
    end

    it "should not send a mail if the required reference count is not reached" do
      lambda {
        do_request
      }.should_not change(ActionMailer::Base.deliveries, :size)
    end

    it "should not send a mail if mail is no configured" do
      @application.references.destroy_all
      (1..(@application.campaign.required_reference_count - 1)).each do
        FactoryGirl.create(:reference, application: @application)
      end

      lambda {
        do_request
      }.should_not change(ActionMailer::Base.deliveries, :size)
    end

    it "should send a mail if the required reference count is reached" do
      @application.references.destroy_all
      (1..(@application.campaign.required_reference_count - 1)).each do
        FactoryGirl.create(:reference, application: @application)
      end
      @application.campaign.update_attributes(
        references_received_mail_from:    'a@example.com',
        references_received_mail_subject: 'Subject',
        references_received_mail_text:    'Text'
      )

      lambda {
        do_request
      }.should change(ActionMailer::Base.deliveries, :size).by(1)
    end

  end

end
