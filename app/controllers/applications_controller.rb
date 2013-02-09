class ApplicationsController < ApplicationController

  before_filter :find_campaign, :only => [ :new, :create, :success ]
  before_filter :find_application, :only => [ :success ]

  def new
    @application = Application.new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if !@contact.save
      @application = Application.new(params[:application])
      render :new
    else
      @application = @contact.applications.build(params[:application])
      @application.campaign = @campaign
      @application.answers = read_answers_from_params(params)
      if !@application.save
        render :new
      else
        redirect_to success_campaign_application_path(@campaign, @application)
      end
    end
  end

  def success
  end

private

  def read_answers_from_params(params)
    params.select { |k,v| k.to_s.start_with?("answer_") }.collect do |key, text|
      question_id = key.split(/_/).last
      next unless question_id
      question = Question.find_by_id(question_id)
      next unless question
      Answer::Application.new(:question => question, :text => text)
    end
  end

  def find_campaign
    @campaign = Campaign.find_by_hashed_id(params[:campaign_id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

  def find_application
    @application = Application.find_by_hashed_id(params[:id]) || raise(ActionController::RoutingError.new("Not Found"))
  end

end
