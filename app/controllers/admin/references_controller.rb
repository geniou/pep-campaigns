class Admin::ReferencesController < Admin::BaseController

  def show
    @reference = Reference.find_by_id(params[:id])
    add_reference_breadcrumb(@reference)
  end

  def edit
    @reference = Reference.find_by_id(params[:id])
    add_reference_breadcrumb(@reference)
    add_breadcrumb('bearbeiten')
  end

  def update
    @reference = Reference.find_by_id(params[:id])
    add_reference_breadcrumb(@reference)
    if @reference.update_attributes(params[:reference])
      redirect_to admin_reference_path(@reference.id), notice: "Angaben erfolgreich bearbeitet."
    else
      render :edit
    end
  end

  def destroy
    reference = Reference.find_by_id(params[:id])
    application = reference.application
    reference.destroy
    redirect_to admin_application_path(application.id)
  end
end
