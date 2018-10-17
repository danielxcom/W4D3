class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user
   # allow in view

  def current_user
    # we are saving a cookie to a column table
    user = User.find_by(session_token: session[:session_token])
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def ensure_not_logged_in
    redirect_to cats_url if logged_in?
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout_user!
    if logged_in?
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

  def logged_in?
    !!current_user
  end
end
