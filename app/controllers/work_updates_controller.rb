class WorkUpdatesController < ApplicationController
  def new
    @work_updates = WorkUpdates.new
    @@work_id = params[:work_id]
    respond_to do |format|
      format.js { render 'work_updates/new' }
    end
  end

  def create; end
end
