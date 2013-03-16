module ApplicationHelper

  def display_text(text)
    return nil if text.nil?
    raw(h(text).gsub(/\n/, "<br/>"))
  end

  def add_subnavigation_item(name, path)
    @subnavigation_items ||= []
    @subnavigation_items << [name, path]
  end
end
