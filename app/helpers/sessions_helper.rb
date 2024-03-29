module SessionsHelper

  def login!(user)
    session[:token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.reset_session_token!
    session[:token] = nil
  end

end
