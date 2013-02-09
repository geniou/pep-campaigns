require 'spec_helper'

describe ReferencesController do

  describe "supply" do

    before :each do
      @reference = FactoryGirl.create(:reference)
    end

    def do_request
      get :supply, :id => @reference.id
    end

    it "should render the submission form" do
      do_request
      assert_response :ok
    end

  end

end
