require 'hashed_id'

class ReferencesController < ApplicationController

  before_filter :find_reference, :only => [ :supply ]

  def supply
  end

private

  def find_reference
    @reference = Reference.find_by_hashed_id(params[:id]) || render(:text => "not found", :status => :not_found)
  end

end
