class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_visitor_identified
  helper_method :minimise_layout?

  private

  def minimise_layout?
    @minimised_layout || false
  end

  def use_minimised_layout
    @minimised_layout = true
  end

  def ensure_visitor_identified
    if cookies[:visitor_identifier].blank?
      cookies.permanent[:visitor_identifier] = SecureRandom.hex(24)
    end
  end

  def current_visitor
    Visitor.new(cookies.fetch(:visitor_identifier))
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
