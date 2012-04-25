module ApplicationHelper

  def full_title(page_title)
    base_title = "Proyecto Final"
    ( page_title.nil? || page_title.empty? ) ? base_title : "#{page_title} | #{base_title}"
  end

end
