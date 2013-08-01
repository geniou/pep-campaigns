class Admin::CampaignsController < Admin::BaseController

  def index
    @campaigns = Campaign.all
    add_breadcrumb 'Kampagnen'
  end

  def show
    @campaign = Campaign.find(params[:id])
    add_campagin_breadcrumb @campaign
  end

  def export
    campaign = Campaign.find(params[:campaign_id])
    respond_to do |format|
      format.csv { send_data Export::Campaign.new(campaign).to_csv }
    end
  end

  def export_references
    campaign = Campaign.find(params[:campaign_id])
    respond_to do |format|
      format.csv { send_data Export::Applications.new(campaign.applications).to_csv }
    end
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
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to admin_campaigns_path, notice: "Kampagne angelegt."
    else
      render action: 'new'
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(campaign_params)
      redirect_to admin_campaign_path(@campaign), notice: "Kampagne bearbeitet."
    else
      render action: 'new'
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :applicant_introduction_text,
                                     :application_introduction_text, :application_credits_text,
                                     :application_success_text, :referee_introduction_text,
                                     :reference_success_text, :required_reference_count,
                                     :open_to_applicants, :open_to_referees,
                                     :references_received_mail_from,
                                     :references_received_mail_subject,
                                     :references_received_mail_text
                                    )
  end
end
