class OfficeTypesController < BackofficeController
  before_action :set_office_type, only: [:edit, :update, :destroy]

  def index
    @office_types = OfficeType.all
  end

  def show; end

  def new
    @office_types = OfficeType.new
  end

  def edit; end

  def create
    @office_type = OfficeType.new(office_type_params)

    respond_to do |format|
      if @office_type.save
        format.html { redirect_to office_types_index_path, notice: 'Tipo de escritório criado com sucesso!' }
        format.json { render :index, status: :created, location: @office_type }
      else
        format.html { render :new }
        format.json { render json: @office_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @office_types.update(office_type_params)
        format.html { redirect_to office_types_index_path, notice: 'Tipo de escritório atualizado com sucesso.' }
        format.json { render :index, status: :ok, location: @office_type }
      else
        format.html { render :edit }
        format.json { render json: @office_types.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office_types.destroy
    respond_to do |format|
      format.html { redirect_to office_types_url, notice: 'Tipo de escritório excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_office_type
      @office_types = OfficeType.find(params[:id])
    end

    def office_type_params
      params.require(:office_type).permit(
        :description)
    end

end
