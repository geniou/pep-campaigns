require 'spec_helper'

describe Admin::ContactsController do

  before { controller.stub(authenticate_admin!: nil) }

  before :each do
    @contact = FactoryGirl.create(:contact)
  end

  describe "index" do

    def do_request(params = {})
      get :index, params
    end

    it "should list contacts" do
      do_request
      assert_response :ok
    end

  end

  describe "show" do

    def do_request(params = {})
      get :show, { :id => @contact.id }.update(params)
    end

    it "should show a simple contact" do
      do_request
      assert_response :ok
    end
  end
end
