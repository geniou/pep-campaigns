require 'hashed_id'

class ReferencesController < SurveyController

  before_filter :find_application, :only => [ :new, :create ]
  before_filter :find_campaign, :only => [ :new, :create ]

  def new
    @reference = Reference.new 
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if !@contact.save
      render :new
    else
      @reference = @contact.references.build(params[:reference])
      @reference.campaign = @campaign
      @reference.application = @application
      @reference.answers = read_answers_from_params(params, Answer::Reference)
      if !@reference.save
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
