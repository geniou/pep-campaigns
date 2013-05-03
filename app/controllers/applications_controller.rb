require 'hashed_id'
class ApplicationsController < ApplicationController

  before_filter :find_campaign
  before_filter :find_application, only: [ :success, :edit, :update ]

  def new
    @application = Application.new
    @application.contact = Contact::Applicant.new
    @campaign.applicant_questions.each do |question|
      answer = @application.applicant_answers.build
      answer.question = question
    end
  end

  def create
    @application = Application.new(params[:application])
    @application.campaign = @campaign
    if @application.save
      redirect_to edit_campaign_application_path(@campaign, @application)
    else
      render :new
    end
  end

  def edit
    # TODO: move logic to model
    @campaign.application_questions.each do |question|
      answer = @application.application_answers.build
      answer.question = question
    end
  end

  def update
    if @application.update_attributes(params[:application])
      redirect_to success_campaign_application_path(@campaign, @application)
    else
      render :edit
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
    @application.campaign = @campaign
  end

end
