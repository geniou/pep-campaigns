require 'spec_helper'

describe Admin::ApplicationsController do

  before { controller.stub(authenticate_admin!: nil) }

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
