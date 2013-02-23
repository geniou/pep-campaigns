class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'
  
  def add_reference_breadcrumb(reference)
    add_application_breadcrumb(reference.application)
    add_breadcrumb "Referenz von '#{reference.contact.name}'", admin_reference_path(reference.id)
  end
  
  def add_application_breadcrumb(application)
    add_campagin_breadcrumb(application.campaign)
    add_breadcrumb "Antrag von '#{application.contact.name}'", admin_application_path(application.id)
  end

  def add_campagin_breadcrumb(campaign)
    add_breadcrumb "Kampagnen", admin_campaigns_path
    add_breadcrumb "Kampagne '#{campaign.name}'", admin_campaign_path(campaign.id)
  end

  def add_breadcrumb(name, path=nil)
    @breadcrumbs ||= []
    @breadcrumbs << [name, path]
  end
  helper_method :add_breadcrumb
end
