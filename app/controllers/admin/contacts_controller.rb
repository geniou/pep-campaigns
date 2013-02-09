class Admin::ContactsController < Admin::BaseController

  before_filter :find_contact, :only => [ :show ]

  def index
    @contacts = Contact.all
  end

  def show
  end

private

  def find_contact 
    @contact = Contact.find_by_id(params[:id])
  end

end
