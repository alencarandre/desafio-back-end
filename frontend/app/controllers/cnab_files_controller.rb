class CnabFilesController < ApplicationController
  def index
    @cnab_files = CnabFile.all
  end

  def new
    @cnab_file ||= CnabFile.new
  end

  def create
    @cnab_file = CnabFileService::Importer.(params)
    respond_with CnabFileService::Processor.(@cnab_file)
  end

  def completed
    @cnab_file = CnabFile.find(params[:cnab_file_id])
    @cnab_file.update_status_to_completed
    respond_with @cnab_file, status: :no_content
  end
end
