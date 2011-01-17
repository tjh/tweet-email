module ApplicationHelper
  def body_id
    controller_name = controller.controller_name.underscore
    action_name     = controller.action_name.underscore
    css_id = "#{controller_name}-#{action_name}"
    css_id << "-#{params[:id]}" if params[:id]
    css_id
  end

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
