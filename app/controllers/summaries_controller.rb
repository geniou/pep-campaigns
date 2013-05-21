class SummariesController < ApplicationController

  def show
    public_summary = PublicSummary.new(params[:id])
    @summary = public_summary.references
    @application = public_summary.application
  end
end
