class ApplicationController < ActionController::Base
  # shared controller logic lives here
  # skip_before_action :verify_authenticity_token # we are back - this will verify our auth tokens upon form submission
  # we don't want to skip verifying the auth token, it is a very useful aspect of rails
  # helper_method takes symbols as arguments, names of methods we want access
  # to in our views
  helper_method :current_user, :logged_in?

  # C - E - L - L - L

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil 
  end

  def logged_in?
    # returns a boolean indicating whether or not there is a current_user
    !!current_user # double not! current_user
    # if there is a current_user, !current_user = false, !false = true
    # if there is no current_user !current_user = true, !true = false
  end
end
