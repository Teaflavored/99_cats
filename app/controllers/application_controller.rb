class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    session_to_find = Session.find_by(session_token: session[:session_token])
    return nil if session_to_find.nil?
    session_to_find.user
  end
  
  def redirect_back_to_cats_if_signed_in
    redirect_to cats_url unless current_user.nil?
  end
end
