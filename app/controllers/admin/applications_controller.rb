class Admin::ApplicationsController < Admin::BaseController

  def show
    @application = Application.find(params[:id])
    @campaign = @application.campaign
    add_application_breadcrumb(@application)
  end

  def edit
    @application = Application.find(params[:id])
    @campaign = @application.campaign
    @campaign.application_questions.each do |question|
      unless question.answers.where(application_id: @application.id).any?
        answer = @application.application_answers.build
        answer.question = question
      end
    end
    add_application_breadcrumb(@application)
    add_breadcrumb('bearbeiten')
  end

  def update
    @application = Application.find(params[:id])
    @campaign = @application.campaign
    if @application.update_attributes(params[:application])
      redirect_to admin_application_path(@application.id), notice: "Angaben erfolgreich bearbeitet."
    else
      render :edit
    end
  end

  def export
    @application = Application.find_by_id(params[:application_id])
    respond_to do |format|
      format.csv { send_data Export::Application.new(@application).to_csv }
    end
  end

  def summary
    @application = Application.find(params[:application_id])
    @summary = Summary.new(@application)
    add_application_breadcrumb(@application)
    add_breadcrumb('Auswertung Referenzen')
  end
end
