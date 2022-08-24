class FileUploadsController < BackofficeController
  def new
    @client = Client.find(params[:client_id])
  end

  def destroy
    @client = Client.find(params[:client_id])
    @client.files.find(params[:id]).purge
    redirect_to request.referrer
  end

  def destroy_file_work
    @work = Work.find(params[:work_id])
    @work.archive_file.find(params[:id]).purge
    redirect_to request.referrer
  end
end
