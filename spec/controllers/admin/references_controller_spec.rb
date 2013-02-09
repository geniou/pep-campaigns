require 'spec_helper'

describe Admin::ReferencesController do

  render_views

  before { controller.stub(authenticate_admin!: nil) }

  describe "show" do

    before :each do
      @reference = FactoryGirl.create(:reference)
    end

    def do_request(params = {})
      get :show, { :id => @reference.id }.update(params)
    end

    it "should show a simple reference" do
      do_request
      assert_response :ok
    end

  end

end
