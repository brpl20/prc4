class FinancesController < ApplicationController
  before_action :authenticate_user!, :set_finance, only: [:show, :edit, :update, :destroy]


  def new
    @finance = Finance.new
  end



  def create
    @finance = Finance.new(finance_params)

    if @finance.save
        redirect_to @finance, notice: 'Financeiro Criado com Sucesso.'
      else
        render :new
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_finance
    @finance  = Finance.find(params[:id])
  end

  def amazon_client
   require 'aws-sdk-s3'
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
  end

