class Admin::CampaignsController < Admin::BaseController

  def index
    @open_campaigns = Campaign.open_to_applicants.all
    @referee_open_campaigns = Campaign.only_open_to_referees.all
    @closed_campaigns = Campaign.closed.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(params[:campaign])
    if @campaign.save
      redirect_to admin_campaigns_path, :notice => "Kampagne angelegt."
    else
      render :action => 'new'
    end
  end
end
