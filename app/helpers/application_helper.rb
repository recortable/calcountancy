# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def title(title)
    content_for(:title) {title}
    "<h1>#{title}</h1>"
  end

  def icon_link_to(icon, text, url, params = {})
    clzz = params[:class] ? params[:class] : ''
    extra = params.merge({:class => "icon icon_#{icon} #{clzz}", :title => text})
    link_to text, url, extra
  end
end
