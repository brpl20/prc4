class FileUploadsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
  end

  def destroy
    @client = Client.find(params[:client_id])
    @client.files.find(params[:id]).purge
    redirect_to edit_client_path(@client)
  end
end
