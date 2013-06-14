class Admin::CampaignsController < Admin::BaseController

  def index
    @campaigns = Campaign.all
    add_breadcrumb 'Kampagnen'
  end

  def show
    @campaign = Campaign.find(params[:id])
    add_campagin_breadcrumb @campaign
  end

  def new
    @campaign = Campaign.new
    add_breadcrumb 'neu Kampagne'
  end

  def edit
    @campaign = Campaign.find(params[:id])
    add_breadcrumb 'Kampagne bearbeiten'
    add_campagin_breadcrumb @campaign
  end

  def create
    @campaign = Campaign.new(params[:campaign])
    if @campaign.save
      redirect_to admin_campaigns_path, :notice => "Kampagne angelegt."
    else
      render :action => 'new'
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      redirect_to admin_campaign_path(@campaign), :notice => "Kampagne bearbeitet."
    else
      render :action => 'new'
    end
  end
end
