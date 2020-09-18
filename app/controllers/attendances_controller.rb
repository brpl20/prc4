class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  # TODO - Arrumar Mailer -- user_maier and application_mailer
  # after_action :send_mail

  # TODO - TESTAR AUTORIZACAO
  load_and_authorize_resource

  def send_mail
    #UserMailer.welcome_email(self).deliver_later
  end


  # GET /atendimentos
  # GET /atendimentos.json
  def index
    @attendances = Attendance.all
  end

  # GET /atendimentos/1
  # GET /atendimentos/1.json
  def show; end

  # GET /atendimentos/new
  def new
    @attendance = Attendance.new
  end

  # GET /atendimentos/1/edit
  def edit
  end


  # POST /atendimentos
  # POST /atendimentos.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Atendimento criado com sucesso.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atendimentos/1
  # PATCH/PUT /atendimentos/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Atendimento criado com sucesso.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atendimentos/1
  # DELETE /atendimentos/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendance_url, notice: 'Atendimento criado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # TODO Arrumar responsible x responsable
    def attendance_params
      params.require(:attendance).permit(
        :name,
        :lastname,
        :origin,
        :status,
        :responsible,
        :telephone,
        :email,
        :subject,
        :notes,
        :channel
        )
    end
end
