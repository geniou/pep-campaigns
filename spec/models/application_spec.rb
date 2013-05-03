require 'spec_helper'

describe Application do

  before :each do
    @campaign = FactoryGirl.create(:campaign)
    @application = FactoryGirl.create(:application, campaign: @campaign)
  end

  it "should be an Application" do
    @application.should be_instance_of(Application)
  end

  describe "required_references?" do

    it "should include applications with the required number of references" do
      @application.complete.should be_false
      Application.complete.size.should == 0
      Application.incomplete.size.should == 1
      Application.incomplete.first.should == @application

      (0..@campaign.required_reference_count).each do
        FactoryGirl.create(:reference, :application => @application)
      end

      Application.complete.size.should == 1
      Application.complete.first.should == @application
      Application.incomplete.size.should == 0
    end

  end

end
