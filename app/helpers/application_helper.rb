module ApplicationHelper

  def display_text(text)
    return nil if text.nil?
    raw(h(text).gsub(/\n/, "<br/>"))
  end

end
