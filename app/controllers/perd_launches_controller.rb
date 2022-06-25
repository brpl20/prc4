class PerdLaunchesController < ApplicationController
  before_action :set_perd_launch, only: %i[show edit update destroy]

  def new
    @perdlaunch = PerdLaunch.new
    @@work_id = params[:work_id]
    respond_to do |format|
      format.js { render 'perd_launches/new' }
    end
  end

  def create
    @perdlaunch = PerdLaunch.new(perdlaunch_params)
    if @perdlaunch.save
      redirect_to work_path(@@work_id)
    end
  end

  def edit
    @@work_id = params[:work_id]
    @perdlaunch = PerdLaunch.find(params[:id])
    respond_to do |format|
      format.js { render 'perd_launches/edit' }
    end
  end

  def update
    respond_to do |format|
      if @perdlaunch.update(perdlaunch_params)
        format.html { redirect_to work_path(@@work_id), notice: 'Perd/Comp Atualizado.' }
      else
        format.html { render :edit }
        format.json { render json: @perdlaunch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @@work_id = params[:work_id]
    @perdlaunch.destroy
    respond_to do |format|
      format.html { redirect_to work_path(@@work_id), notice: 'Per/Comp apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def set_perd_launch
    @perdlaunch = PerdLaunch.find(params[:id]) if params[:id]
  end

  private

  def perdlaunch_params
    params.require(:perd_launch).permit(
      :perd_number,
      :shipping_date,
      :payment_date,
      :status,
      :tributary_id
    )
  end
end
