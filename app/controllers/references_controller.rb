require 'hashed_id'

class ReferencesController < ApplicationController

  before_filter :find_application, :only => [ :new ]
  before_filter :find_campaign, :only => [ :new ]

  def new
    @reference = Reference.new 
  end

private

  def find_application
    @application = Application.find_by_hashed_id(params[:application_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
