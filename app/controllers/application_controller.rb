# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] && !User.where(id: session[:user_id]).blank?
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end
end
