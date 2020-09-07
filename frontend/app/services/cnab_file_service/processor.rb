class CnabFileService::Processor < ApplicationService
  PROCESSING_QUEUE_URL = ENV['PROCESSING_QUEUE_URL']

  def initialize(cnab_file)
    @cnab_file = cnab_file
  end

  def call
    if model_valid?
      enqueue
      @cnab_file.update_status_to_processing
    end

    @cnab_file
  end

  private

  def model_valid?
    @cnab_file.persisted? && @cnab_file.valid?
  end

  def enqueue
    sqs_client
      .send_message(
        queue_url: PROCESSING_QUEUE_URL, 
        message_body: message
      )
  end

  def message
    {
      id: @cnab_file.id,
      key: @cnab_file.file.key,
    }.to_json
  end

  def sqs_client
    Aws::Client.sqs
  end
end
