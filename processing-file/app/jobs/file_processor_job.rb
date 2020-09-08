class FileProcessorJob < ApplicationJob
  queue_as :processing

  def perform(processing_id: , key: )
    errors = []

    BucketReaderService.(key) do |line, position|
      errors += CnabService::Processor.(processing_id, line, position)
    end

    notify_errors(processing_id, errors) if errors.present?

    notify_finish(processing_id)
  end

  private

  def notify_errors(processing_id, errors)
    # TODO notify errors
  end

  def notify_finish(processing_id)
    CompleteNotifierService.(processing_id)
  end
end
