require 'spec_helper'

describe ApplicationsController do

  describe "new" do

    before :each do
      @campaign = FactoryGirl.create(:campaign)
    end

    def do_request(params = {})
      get :new, { :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should render the application form for a valid campaign" do
      do_request
      assert_response :ok
      assigns[:application].should be_an_instance_of(Application)
    end

    it "should render 404 for an invalid campaign hash" do
      lambda {
        do_request(:campaign_id => "#{@campaign.hashed_id}garbage")
      }.should raise_error(ActionController::RoutingError)
    end

  end

end
