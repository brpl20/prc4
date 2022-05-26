class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

def after_sign_in_path_for(resource)
  pages_dashboard_path
end

rescue_from CanCan::AccessDenied do |exception|
  respond_to do |format|
    format.json { head :forbidden, content_type: 'text/html' }
    format.html { redirect_to main_app.root_url, notice: exception.message }
    format.js   { head :forbidden, content_type: 'text/html' }
  end
end

protected

    def layout_by_resource
      if devise_controller?
        "application"
      else
        "backoffice"
      end
    end


end
