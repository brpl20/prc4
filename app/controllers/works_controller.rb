# frozen_string_literal: true

class WorksController < BackofficeController
  before_action :set_work, only: %i[show edit update destroy templater]

  def index
    @works = Work.includes(:clients).all
  end

  def new
    @work = Work.new
    @work.client_works.build
    @work.work_offices.build
    @work.build_recommendation_work
    @work.powers.build
    @work.build_tributary
    @client = Client.find(params[:client]) if params[:client]
  end

  def show
    @work = Work.find(params[:id])
    @work_updates = @work.work_updates.order(updated_at: :desc)
    @client = @work.clients.last
    @url = @work.document['aws_link'] if @work.document
  end

  def generate_docs_work(work)
    AwsService::AwsService.aws_save_work(work, document="procuracao_simples", bucket='prcstudio3herokubucket')
    #AwsService::AwsService.aws_save_work(work, document="wdocs", bucket='prcstudio3herokubucket')
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      #UpdateWorkMailer.notify_new_work(@work).deliver_later
      #raise
      AwsService::AwsService.aws_save_work(@work, 'wdocs', bucket='prcstudio3herokubucket')
      redirect_to @work
    else
      render :new,
      notice: "Erro!!"
    end
  end

  def edit
    @client = Client.find(params[:client_id])
  end

  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Trabalho Atualizado. Cuidado * Procuracão Não Atualizada' }
        format.json { render :show, status: :ok, location: @work, notice: 'Trabalho Atualizado. Cuidado * Procuracão Não Atualizada!!!'}
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @work.destroy
      redirect_to works_path, notice: "Excluído com sucesso!"
    else
      redirect_to works_path, notice: "Houve um problema"
    end
  end

  private

  def set_work
    @work = Work.includes(:work_offices, :offices, :clients, :client_works).find(params[:id])
  end

  def work_params
    params.require(:work).permit(
      :subject,
      :action,
      :number,
      :rate_percentage,
      :rate_percentage_exfield,
      :rate_fixed,
      :rate_fixed_exfield,
      :rate_work,
      :rate_parceled,
      :rate_parceled_exfield,
      :folder,
      :initial_atendee,
      :user_id,
      :procuration_lawyer,
      :procuration_intern,
      :procuration_paralegal,
      :partner_lawyer,
      :lawyer_id,
      :note,
      :document_pendent,
      checklist_document_ids: [],
      checklist_ids: [],
      procedure_ids: [],
      power_ids: [],
      archive_file: [],
      client_works_attributes: %i[id client_id _destroy],
      recommendation_work_attributes: %i[id client_id work_id percentage commission _destroy],
      work_offices_attributes: %i[id office_id _destroy],
      tributary_attributes: [:id,
                            :compensation,
                            :craft,
                            :lawsuit,
                            :projection,
                            :work_id]
      )
  end

end
