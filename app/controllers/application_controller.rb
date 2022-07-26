# frozen_string_literal: true

# Class que aplica logica para todo o sistema
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user
      'application'
    else
      'backoffice'
    end
  end
end
