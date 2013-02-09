require 'spec_helper'

describe ReferencesController do

  before :each do
    @campaign = FactoryGirl.create(:campaign)
    @application = FactoryGirl.create(:application, :campaign => @campaign)
  end

  describe "new" do

    def do_request(params = {})
      get :new, { :application_id => @application.hashed_id,
                  :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should render the reference submission form for a valid application" do
      do_request
      assert_response :ok
      assigns[:reference].should be_instance_of(Reference)
    end

    it "should render 404 for an invalid hash" do
      lambda {
        do_request(:application_id => "#{@application.hashed_id}garbage")
      }.should raise_error(ActionController::RoutingError)
    end

  end

end
