require 'spec_helper'

describe ApplicationsController do

  before :each do
    @campaign = FactoryGirl.create(:campaign)
  end

  describe "new" do

    render_views 

    def do_request(params = {})
      get :new, { :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should render the application form for a valid campaign" do
      do_request
      assert_response :ok
      assigns[:application].should be_an_instance_of(Application)
      assigns[:contact].should be_an_instance_of(Contact)
      response.body.should have_selector "div#contact"
    end

    it "should render 404 for an invalid campaign hash" do
      lambda {
        do_request(:campaign_id => "#{@campaign.hashed_id}garbage")
      }.should raise_error(ActionController::RoutingError)
    end

  end

  describe "create" do

    before :each do
      @contact_details = {
        first_name: "Some",
        last_name: "Person",
        organisation: "Some organisation",
        email: "email@example.com",
        website: "http://website.com",
        street_name: "A Street",
        house_number: "123",
        "birthdate(1i)" => "1980",
        "birthdate(2i)" => "01",
        "birthdate(3i)" => "01",
        sex: "m",
        nationality: "French"
      }
      @name = "Some name"
    end

    def do_request(params = {})
      get :create, { :contact => @contact_details, :name => @name, :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should create a new application" do
      lambda {
        do_request
      }.should change(Application, :count)
    end

    it "should require any questions to be answered" do
      @questions = (0..5).collect do
        FactoryGirl.create :application_question, :campaign => @campaign
      end

      lambda {
        do_request
      }.should_not change(Application, :count)
    end

    it "should create the application if the questions have been answered" do
      @questions = (0..5).collect do
        FactoryGirl.create :application_question, :campaign => @campaign
      end
      @answers = @questions.inject({}) do |params, question|
        params["answer_#{question.id}"] = "I AM A FISH"
        params
      end

      lambda {
        do_request(@answers)
      }.should change(Application, :count)
    end

  end

end
