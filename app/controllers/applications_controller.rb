class ApplicationsController < ApplicationController

  before_filter :find_campaign, :only => [ :new ]

  def new
    @application = Application.new
    @contact = Contact.new
  end

private

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
