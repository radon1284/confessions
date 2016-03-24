class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_visitor_identified

  private

  def ensure_visitor_identified
    if cookies[:visitor_identifier].blank?
      cookies.permanent[:visitor_identifier] = SecureRandom.hex(24)
    end
  end

  def current_visitor
    Visitor.new(cookies.fetch(:visitor_identifier))
  end
end
