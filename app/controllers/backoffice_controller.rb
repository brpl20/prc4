# frozen_string_literal: true

# Class que aplica logica para models dependentes de backoffice
class BackofficeController < ApplicationController
  before_action :authenticate_user!
  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user
      'application'
    else
      'backoffice'
    end
  end
end
