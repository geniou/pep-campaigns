class SummariesController < ApplicationController

  def show
    @summary = PublicSummary.new(params[:id])
  end
end
