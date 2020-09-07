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
end
