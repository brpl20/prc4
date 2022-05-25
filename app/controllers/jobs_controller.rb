# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]
  before_action :set_client, only: %i[new create]

  def index
    @jobs = Job.all
  end

  def show; end

  def new
    @job = Job.new
  end

  def edit; end

  def create
    @job = @cli.jobs.build(job_params)
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
    @job = Job.find(params[:id])
  end

  def set_client
    @cli = Client.find(params[:client_id])
  end

  def job_params
    params.require(:job).permit(
      :description,
      :deadline,
      :responsable,
      :status,
      :client_id
    )
  end
end
