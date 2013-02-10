class Admin::ReferencesController < Admin::BaseController

  before_filter :find_reference, :only => [ :show ]
  before_filter :set_breadcrumb, :only => [ :show ]

  def show
  end

private

  def find_reference 
    @reference = Reference.find_by_id(params[:id])
  end
  
  def set_breadcrumb
    add_reference_breadcrumb(@reference)
  end

end
