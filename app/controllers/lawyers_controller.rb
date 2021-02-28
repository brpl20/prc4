class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /lawyers
  # GET /lawyers.json
  def index
    @lawyers = Lawyer.all
  end

  # GET /lawyers/1
  # GET /lawyers/1.json
  def show
  end

  # GET /lawyers/new
  def new
    @lawyer = Lawyer.new
  end

  # GET /lawyers/1/edit
  def edit
  end

  # POST /lawyers
  # POST /lawyers.json
  def create
    @lawyer = Lawyer.new(lawyer_params)
      if @lawyer.save
        redirect_to @lawyer, notice: 'Lawyer was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /lawyers/1
  # PATCH/PUT /lawyers/1.json
  def update
    respond_to do |format|
      if @lawyer.update(lawyer_params)
        format.html { redirect_to @lawyer, notice: 'Lawyer was successfully updated.' }
        format.json { render :show, status: :ok, location: @lawyer }
      else
        format.html { render :edit }
        format.json { render json: @lawyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lawyers/1
  # DELETE /lawyers/1.json
  def destroy
    @lawyer.destroy
    respond_to do |format|
      format.html { redirect_to lawyers_url, notice: 'Lawyer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lawyer
      @lawyer = Lawyer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lawyer_params
      params.require(:lawyer).permit(
        :gender,
        :general_register,
        :social_number,
        :oab_number,
        :name,
        :lastname,
        :citizenship,
        :civilstatus,
        :birth,
        :mothername,
        :email,
        :address,
        :city,
        :state,
        :telephone,
        :email,
        :bank,
        :agency,
        :account,
        :zip
        )
    end
end
