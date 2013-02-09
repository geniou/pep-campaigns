require 'spec_helper'

describe ReferencesController do

  before :each do
    @campaign = FactoryGirl.create(:campaign)
    @application = FactoryGirl.create(:application, :campaign => @campaign)
  end

  describe "new" do

    def do_request(params = {})
      get :new, { :application_id => @application.hashed_id,
                  :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should render the reference submission form for a valid application" do
      do_request
      assert_response :ok
      assigns[:reference].should be_instance_of(Reference)
    end

    it "should render 404 for an invalid hash" do
      lambda {
        do_request(:application_id => "#{@application.hashed_id}garbage")
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
    end

    def do_request(params = {})
      get :create, { :contact => @contact_details, :application_id => @application.hashed_id, :campaign_id => @campaign.hashed_id }.update(params)
    end

    it "should create a new reference" do
      lambda {
        do_request
      }.should change(Reference, :count)
    end

    it "should require any questions to be answered" do
      @questions = (0..5).collect do
        FactoryGirl.create :reference_question, :campaign => @campaign
      end

      lambda {
        do_request
      }.should_not change(Reference, :count)
    end

    it "should create the application if the questions have been answered" do
      @questions = (0..5).collect do
        FactoryGirl.create :reference_question, :campaign => @campaign
      end
      @answers = @questions.inject({}) do |params, question|
        params["answer_#{question.id}"] = "I AM A FISH"
        params
      end

      lambda {
        do_request(@answers)
      }.should change(Reference, :count)
    end

  end

end
