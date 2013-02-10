require 'spec_helper'

describe ApplicationsController do

  describe "new" do
    it "should render 404 for an invalid campaign hash" do
      Campaign.should_receive(:find_by_hashed_id).and_return(nil)
      lambda {
        get :new, campaign_id: 'foo'
      }.should raise_error(ActionController::RoutingError)
    end
  end
end
