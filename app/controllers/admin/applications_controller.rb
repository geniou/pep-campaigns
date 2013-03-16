class Admin::ApplicationsController < Admin::BaseController

  before_filter :find_campaign, :only => [ :index ]
  before_filter :find_application, :only => [ :show ]
  before_filter :set_breadcrumb, :only => [ :show ]

  def index
    @complete_applications = @campaign.applications.complete
    @incomplete_applications = @campaign.applications.incomplete
  end

  def show
  end

  private

  def find_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def find_application
    @application = Application.find(params[:id])
  end

  def set_breadcrumb
    add_application_breadcrumb(@application)
  end

end
