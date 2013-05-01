require 'hashed_id'
class ApplicationsController < ApplicationController

  before_filter :find_campaign, :only => [ :new, :create, :success ]
  before_filter :find_application, :only => [ :success ]

  def new
    @application = Application.new
    @application.contact = Contact.new
    # TODO: move logic to model
    @campaign.application_questions.each do |question|
      answer = @application.application_answers.build
      answer.question = question
    end
    @campaign.applicant_questions.each do |question|
      answer = @application.applicant_answers.build
      answer.question = question
    end
  end

  def create
    @application = Application.new(params[:application])
    @application.campaign = @campaign
    if !@application.save
      render :new
    else
      redirect_to success_campaign_application_path(@campaign, @application)
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
