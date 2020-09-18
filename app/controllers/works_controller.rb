class WorksController < ApplicationController
before_action :set_work, only: [:show, :edit, :update, :destroy, :templater]

# redirect with params
# redirect_to controller: 'thing', action: 'edit', id: 3, something: 'else'

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  #def materia
  #@materia = {materia: ["Previdencíário", "Cível"] }
  #end

  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  def field_list
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to @work
    else
      render :new
    end
  end

  def edit; end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'work Atualizado. Cuidado * Procuracão Não Atualizada' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @works.destroy
    redirect_to works_path
  end

  private

  def set_work
    @work = Work.find(params[:id])
  end

  # TODO Tirar vários campos do plural
  def work_params
    params.require(:work).permit(
      :type,
      :subject,
      :action,
      :number,
      :rate_percentage,
      :rate_percentage_exfield,
      :rate_fixed,
      :rate_fixed_exfield,
      :rate_work,
      :rate_parceled,
      :powers,
      :recommendation,
      :recommendation_comission,
      :folder,
      :initial_atendee,
      :responsible_lawyer,
      :procuration_lawyer,
      :procuration_intern,
      :procuration_paralegal,
      :partner_lawyer,
      :notes,
      :checklist,
      :checklist_documents,
      :documento_pendent,
      :lawyer_id)
  end

end




