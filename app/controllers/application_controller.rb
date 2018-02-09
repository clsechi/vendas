class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_session(session_name, session_value)
    session_name = session_name.to_sym
    session[session_name] = session_value
  end
end
