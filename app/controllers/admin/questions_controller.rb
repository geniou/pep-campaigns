class Admin::QuestionsController < Admin::BaseController
  before_filter :load_campaign
  before_filter :set_breadcrumb

  def index
    @application_questions = @campaign.application_questions
    @reference_questions = @campaign.reference_questions
  end

  def new
    @question = Question.new
    @question.options = ''
    add_breadcrumb 'Fragen', admin_campaign_questions_path(@campaign.id)
    add_breadcrumb 'Frage anlegen'
  end

  def create
    params[:question]['options'] = params[:question]['options'].split(',').collect(&:strip)
    @question = @campaign.questions.new(params[:question])

    if @question.save
      redirect_to admin_campaign_questions_path(campaign_id: @campaign.id), :notice => "Frage angelegt."
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
    @question.options = @question.options.join(',')
    add_breadcrumb 'Frage bearbeiten'
  end

  def update
    params[:question]['options'] = params[:question]['options'].split(',').collect(&:strip)
    @question = Question.find(params[:id])
    @question.update_attributes(params['question'])

    if @question.save
      redirect_to admin_campaign_questions_path(@campaign), :notice => "Frage gaendert."
    else
      render :action => 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to admin_campaign_questions_path(@campaign), :notice => "Frage geloescht."
  end

  private

  def load_campaign
    @campaign = Campaign.find(params[:campaign_id].to_i)
  end

  def set_breadcrumb
    add_campagin_breadcrumb(@campaign)
    add_breadcrumb 'Fragen', admin_campaign_questions_path(campaign_id: @campaign.id)
  end
end
