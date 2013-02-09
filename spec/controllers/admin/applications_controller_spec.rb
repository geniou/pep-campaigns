require 'spec_helper'

describe Admin::ApplicationsController do

  render_views

  describe "index" do

    def do_request
      get :index
    end

    it "should render the index page" do
      do_request
      assert_response :ok
    end    

  end

  describe "show" do

    before :each do
      @application = FactoryGirl.create(:application)
    end

    def do_request(params = {})
      get :show, { :id => @application.id }.update(params)
    end

    it "should show a simple application" do
      do_request
      assert_response :ok
    end

    it "should show an application with references" do
      (0..5).each do
        FactoryGirl.create(:reference, :application => @application)
      end
      do_request
      assert_response :ok
    end

  end

end
