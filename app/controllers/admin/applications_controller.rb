class Admin::ApplicationsController < ApplicationController

  before_filter :find_application, :only => [ :show ]

  def index
    @complete_applications = Application.complete
    @incomplete_applications = Application.incomplete
  end

private

  def find_application
    @application = Application.find_by_id(params[:id])
  end

end
