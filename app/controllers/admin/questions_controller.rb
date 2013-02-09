class Admin::QuestionsController < Admin::BaseController
  before_filter :load_campaign

  def index
    @application_questions = @campaign.application_questions
    @reference_questions = @campaign.reference_questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = if params[:question][:type] == 'Question::Application'
      @campaign.application_questions
    else
      @campaign.reference_questions
    end.new(params[:question].except(:type))
    
    if @question.save
      redirect_to admin_campaign_questions_path(campaign_id: @campaign.id), :notice => "Frage angelegt."
    else
      render :action => 'new'
    end
  end

  private
  
  def load_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
