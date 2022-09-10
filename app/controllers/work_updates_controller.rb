# frozen_string_literal: true

# controller da modal de adicao de atualizacoes de works
class WorkUpdatesController < BackofficeController
  before_action :set_work_updating, only: %i[edit update]

  def new
    @work_update = WorkUpdate.new
    @@work_id = params[:work_id]
    respond_to do |format|
      format.js { render 'work_updates/new' }
    end
  end

  def create
    @work_update = WorkUpdate.new(work_update_params)
    redirect_to work_path(@@work_id) if @work_update.save
  end

  def edit
    @@work_id = params[:work_id]
    respond_to do |format|
      format.js { render 'work_updates/edit' }
    end
  end

  def update
    if @work_update.update(work_update_params)
      redirect_to work_path(@@work_id), notice: 'Status atualizado.'
    else
      render :edit
    end
  end

  private

  def set_work_updating
    @work_update = WorkUpdate.find(params[:id])
  end

  def work_update_params
    params.require(:work_update).permit(
      :description,
      :show_to,
      :work_id
    )
  end
end
