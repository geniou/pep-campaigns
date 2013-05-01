class Admin::ReferencesController < Admin::BaseController

  before_filter :find_reference
  before_filter :set_breadcrumb

  def show
  end

  def edit
    add_breadcrumb('bearbeiten')
  end

  def update
    if @reference.update_attributes(params[:reference])
      redirect_to admin_reference_path(@reference.id), notice: "Angaben erfolgreich bearbeitet."
    else
      render :edit
    end
  end

  private

  def find_reference
    @reference = Reference.find_by_id(params[:id])
  end

  def set_breadcrumb
    add_reference_breadcrumb(@reference)
  end
end
