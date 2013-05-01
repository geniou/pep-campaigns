require 'hashed_id'
class ReferencesController < ApplicationController

  before_filter :find_application, :only => [ :new, :create ]
  before_filter :find_campaign, :only => [ :new, :create ]

  def new
    @reference = Reference.new
    @reference.contact = Contact.new
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
    @reference = Reference.new(params[:reference])
    @reference.campaign = @campaign
    @reference.application = @application
    if !@reference.save
      render :new
    else
      if @application.references.reload.size == @campaign.required_reference_count
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

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
