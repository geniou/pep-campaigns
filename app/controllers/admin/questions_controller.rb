class Admin::QuestionsController < Admin::BaseController
  before_filter :load_campaign
  before_filter :set_breadcrumb

  def index
    @application_questions = @campaign.application_questions
    @reference_questions = @campaign.reference_questions
    add_breadcrumb 'Fragen'
  end

  def new
    @question = Question.new
    add_breadcrumb 'Fragen', admin_campaign_questions_path(@campaign.id)
    add_breadcrumb 'Frage anlegen'
  end

  def create
    @question = @campaign.questions.new(params[:question])
    @question.type = 'Question'

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

  def set_breadcrumb
    add_campagin_breadcrumb(@campaign)
  end
end
