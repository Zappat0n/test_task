module ApplicationHelper

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if logged_in?
  end

  def require_login
    redirect_to login_path, alert: 'You must be logged in to access this section' unless logged_in?
  end

  def react_component(name, props)
    content_tag(:div, { id: name, data: { react_props: props }}) do
    end
  end

end
