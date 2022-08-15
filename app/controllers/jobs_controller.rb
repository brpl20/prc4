# frozen_string_literal: true

class JobsController < BackofficeController
  before_action :set_job, only: %i[show edit update destroy]

  def index
    @jobs = Job.all
  end

  def show; end

  def new
    @job = Job.new
    @client = Client.find(params[:client_id]) if params[:client_id]
    @work = Work.find(params[:work_id]) if params[:work_id]
  end

  def edit
    @client = Client.find(@job.client_id)
    @work = @job.work_id ? Work.find(@job.work_id) : nil
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Tarefa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Tarefa apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id]) if params[:id]
  end

  def job_params
    params.require(:job).permit(
      :description,
      :deadline,
      :responsable,
      :status,
      :client_id,
      :priority,
      :comment,
      :work_id
    )
  end
end
