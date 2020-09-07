class CnabService::Processor < ApplicationService
  SAVE_DATA_QUEUE_URL = ENV['SAVE_DATA_QUEUE_URL']

  def initialize(processing_id, line, position)
    @processing_id = processing_id
    @line = line
    @position = position
  end

  def call
    errors = CnabService::PreValidator.(@line, @position)

    if errors.blank?
      cnab = CnabService::Parser.(@line)
      if cnab.valid?
        cnab.processing_id = @processing_id
        enqueue_to_save(cnab)
      else
        errors += cnab.errors.full_messages
      end
    end

    errors
  end

  private

  def enqueue_to_save(cnab)
    sqs_client
      .send_message(
        queue_url: SAVE_DATA_QUEUE_URL, 
        message_body: cnab.serialize
      )
  end

  def sqs_client
    Aws::Client.sqs
  end
end
