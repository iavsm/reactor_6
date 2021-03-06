# frozen_string_literal: true

# Application controller to handle session
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def required_user
    unless logged_in?
      flash[:alert] = 'You need to login to perform this action!!'
      redirect_to login_path
    end
  end

end
