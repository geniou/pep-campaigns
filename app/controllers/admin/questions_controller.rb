class Admin::QuestionsController < Admin::BaseController
  before_filter :load_campaign
  before_filter :set_breadcrumb
  before_filter :prepare_options, only: [:create, :update]

  def index
    @questions = {
      applicant:   @campaign.applicant_questions,
      application: @campaign.application_questions,
      referee:     @campaign.referee_questions,
      reference:   @campaign.reference_questions
    }
  end

  def new
    @question = Question.new
    @question.options = ''
    add_breadcrumb 'Fragen', admin_campaign_questions_path(@campaign.id)
    add_breadcrumb 'Frage anlegen'
  end

  def create
    @question = @campaign.questions.new(params[:question])
    save_question(@question, :new)
  end

  def edit
    @question = Question.find(params[:id])
    @question.options = @question.options.join(',')
    add_breadcrumb 'Frage bearbeiten'
  end

  def update
    @question = Question.find(params[:id]).update_attributes(params['question'])
    save_question(@question, :edit)
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

  def prepare_options
    params[:question]['options'] = params[:question]['options'].split(',').collect(&:strip)
  end

  def save_question(question, action)
    if question.save
      redirect_to admin_campaign_questions_path(campaign_id: @campaign.id), notice: "Frage gespeichert."
    else
      render action: action
    end
  end
end
