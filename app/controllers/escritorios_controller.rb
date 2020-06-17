class EscritoriosController < ApplicationController
  before_action :set_escritorio, only: [:show, :edit, :update, :destroy]

  # GET /escritorios
  # GET /escritorios.json
  def index
    @escritorios = Escritorio.all
  end

  # GET /escritorios/1
  # GET /escritorios/1.json
  def show
  end

  # GET /escritorios/new
  def new
    @escritorio = Escritorio.new
  end

  # GET /escritorios/1/edit
  def edit
  end

  # POST /escritorios
  # POST /escritorios.json
  def create
    @escritorio = Escritorio.new(escritorio_params)

    respond_to do |format|
      if @escritorio.save
        format.html { redirect_to @escritorio, notice: 'Escritorio was successfully created.' }
        format.json { render :show, status: :created, location: @escritorio }
      else
        format.html { render :new }
        format.json { render json: @escritorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /escritorios/1
  # PATCH/PUT /escritorios/1.json
  def update
    respond_to do |format|
      if @escritorio.update(escritorio_params)
        format.html { redirect_to @escritorio, notice: 'Escritorio was successfully updated.' }
        format.json { render :show, status: :ok, location: @escritorio }
      else
        format.html { render :edit }
        format.json { render json: @escritorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /escritorios/1
  # DELETE /escritorios/1.json
  def destroy
    @escritorio.destroy
    respond_to do |format|
      format.html { redirect_to escritorios_url, notice: 'Escritorio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escritorio
      @escritorio = Escritorio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def escritorio_params
      params.require(:escritorio).permit(:nome, :oab, :cnpj, :tipo, :fundacao, :endereco, :cidade, :estado, :cep, :site, :telefone, :banco, :agencia, :conta)
    end
end
