class PagesController < ApplicationController
  layout 'backoffice'

  def index
  end

  def dashboard
    @clients = Client.all
    @works = Work.last(3)
  end

  def help
  end

  def plans
  end
end
