class Admin::CampaignsController < Admin::BaseController

  before_filter :find_campaign, :only => [ :show, :edit ]

  def index
    @open_campaigns = Campaign.open_to_applicants.all
    @referee_open_campaigns = Campaign.only_open_to_referees.all
    @closed_campaigns = Campaign.closed.all
  end

  def new
    @campaign = Campaign.new
  end

  def edit
    @campaign = Campaign.find(params[:id])
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
      redirect_to admin_campaigns_path, :notice => "Kampagne bearbeitet."
    else
      render :action => 'new'
    end
  end

private

  def find_campaign
    @campaign = Campaign.find_by_id(params[:id])
  end

end
