module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def csrf_token
    "<input type=\"hidden\"
           name=\"authenticity_token\"
           value=\"#{form_authenticity_token}\" >".html_safe
  end
end
