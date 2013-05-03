class Admin::SummariesController < Admin::BaseController

  def references
    @application = Application.find(params[:application_id])
    @summary = Summary.new(@application).references
    add_application_breadcrumb(@application)
    add_breadcrumb('Auswertung Referenzen')
  end
end
