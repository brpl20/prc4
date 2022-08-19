# frozen_string_literal: true

class OfficesController < BackofficeController

  before_action :set_office, only: %i[show edit update destroy]

  def index
    @offices = Office.all
  end

  def show; end

  def new
    @office = Office.new
    @office.build_bank
  end

  def edit; end

  def create
    @office = Office.new(office_params)
    # @office.bank.name = '' if @office.bank.name.nil?
    # @office.bank.agency = 0 if @office.bank.agency.nil?
    # @office.bank.account = 0 if @office.bank.account.nil?
    if @office.save
      redirect_to @office, notice: 'Escritório criado com sucesso!'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, notice: 'Office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_office
    @office = Office.find(params[:id])
  end

    def office_params
      params.require(:office).permit(
        :name,
        :oab,
        :cnpj_number,
        :society,
        :foundation,
        :address,
        :city,
        :state,
        :zip,
        :site,
        :telephone,
        :email,
        :user_id,
        :office_type_id,
        bank_attributes:   [:id, :name, :agency, :account, :_destroy])
    end
end
