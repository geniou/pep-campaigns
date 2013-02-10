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
end
