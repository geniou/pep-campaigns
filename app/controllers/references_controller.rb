require 'hashed_id'
class ReferencesController < ApplicationController

  before_filter :find_application
  before_filter :find_campaign
  before_filter :check_if_closed

  def new
    @reference = Reference.new
    @reference.contact = Contact::Referee.new
    @campaign.referee_questions.each do |question|
      answer = @reference.referee_answers.build
      answer.question = question
    end
    @campaign.reference_questions.each do |question|
      answer = @reference.reference_answers.build
      answer.question = question
    end
  end

  def create
    @reference = Reference.new(reference_params)
    @reference.campaign = @campaign
    @reference.application = @application
    if !@reference.save
      render :new
    else
      if @application.references_received_mail? && @campaign.references_received_mail?
        UserMailer.references_received_mail(@application).deliver
      end
      redirect_to success_campaign_application_reference_path(@campaign, @application, @reference)
    end
  end

  def success
  end

  private

  def find_application
    @application = Application.find_by_hashed_id(params[:application_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def check_if_closed
    unless @campaign.open_to_referees
      return render :closed
    end
  end

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def reference_params
    params.require(:reference).permit!
  end
end
