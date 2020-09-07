class CnabFileService::Importer < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    CnabFile.create(params) do |cnab_file|
      cnab_file.status = :imported
    end
  end

  private

  def params
    return {} if @params[:cnab_file].blank?

    @params
      .require(:cnab_file)
      .permit(:file)
  end
end
