require 'spec_helper'

describe ReferencesController do

  describe "supply" do

    before :each do
      @reference = FactoryGirl.create(:reference)
    end

    def do_request(params = {})
      get :supply, { :id => @reference.hashed_id }.update(params)
    end

    it "should render the submission form for a valid reference" do
      do_request
      assert_response :ok
    end

    it "should render 404 for an invalid hash" do
      do_request(:id => "#{@reference.hashed_id}garbage")
      assert_response :not_found
    end

  end

end
