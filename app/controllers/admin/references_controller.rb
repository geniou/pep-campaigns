class Admin::ReferencesController < Admin::BaseController

  before_filter :find_reference, :only => [ :show ]

  def show
  end

private

  def find_reference 
    @reference = Reference.find_by_id(params[:id])
  end

end
