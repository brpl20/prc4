class FileUploadsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
  end

  def destroy
    @client = Client.find(params[:client_id])
    @client.files.find(params[:id]).purge
    redirect_to request.referrer
  end
end
