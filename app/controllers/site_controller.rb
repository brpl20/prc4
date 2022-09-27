# frozen_string_literal: true

# Class que aplica logica para models dependentes de area do cliente
class SiteController < ApplicationController
  before_action :authenticate_customer!
  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :customer
      'application'
    else
      'site'
    end
  end
end
