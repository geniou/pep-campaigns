class Admin::ApplicationsController < Admin::BaseController

  before_filter :find_campaign,    only: [:index]
  before_filter :find_application, except: [:index]
  before_filter :set_breadcrumb,   except: [:index]

  def index
    @complete_applications = @campaign.applications.complete
    @incomplete_applications = @campaign.applications.incomplete
  end

  def show
  end

  def edit
    add_breadcrumb('bearbeiten')
  end

  def update
    if @application.update_attributes(params[:application])
      redirect_to admin_application_path(@application.id), notice: "Angaben erfolgreich bearbeitet."
    else
      render :edit
    end
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
