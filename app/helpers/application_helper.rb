module ApplicationHelper

  def add_subnavigation_item(name, path)
    @subnavigation_items ||= []
    @subnavigation_items << [name, path]
  end
end
