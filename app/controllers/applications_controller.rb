class ApplicationsController < SurveyController

  before_filter :find_campaign, :only => [ :new, :create, :success ]
  before_filter :find_application, :only => [ :success ]

  def new
    @application = Application.new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if !@contact.save
      @application = Application.new(params[:application])
      render :new
    else
      @application = @contact.applications.build(params[:application])
      @application.campaign = @campaign
      @application.answers = read_answers_from_params(params, Answer::GrantApplication)
      if !@application.save
        render :new
      else
        redirect_to success_campaign_application_path(@campaign, @application)
      end
    end
  end

  def success
  end

private

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def find_application
    @application = Application.find_by_hashed_id(params[:id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
