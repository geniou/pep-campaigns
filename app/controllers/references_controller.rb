require 'hashed_id'

class ReferencesController < ApplicationController

  before_filter :find_application, :only => [ :new, :create ]
  before_filter :find_campaign, :only => [ :new, :create ]

  def new
    @reference = Reference.new 
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if !@contact.save
      puts "Failed to save contact"
      render :new
    else
      @reference = @contact.references.build(params[:reference])
      @reference.campaign = @campaign
      @reference.application = @application
      if !@reference.save
        puts "Failed to save reference"
        render :new
      else
        redirect_to success_campaign_application_reference_path(@campaign, @application, @reference)
      end
    end
  end

  def success
  end

private

  def find_application
    @application = Application.find_by_hashed_id(params[:application_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
