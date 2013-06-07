class Admin::ApplicationsController < Admin::BaseController

  def show
    @application = Application.find(params[:id])
    @campaign = @application.campaign
  end

  def edit
    @application = Application.find(params[:id])
    @campaign = @application.campaign
    add_breadcrumb('bearbeiten')
  end

  def update
    @application = Application.find(params[:id])
    @campaign = @application.campaign
    if @application.update_attributes(params[:application])
      redirect_to admin_application_path(@application.id), notice: "Angaben erfolgreich bearbeitet."
    else
      render :edit
    end
  end

  def export
    @application = Application.find_by_id(params[:application_id])
    respond_to do |format|
      format.csv { send_data CSV.generate(col_sep: ";", force_quotes: true) { |csv| Export.new(@application).references(csv) } }
    end
  end

  private

  def set_breadcrumb
    add_application_breadcrumb(@application)
  end
end
