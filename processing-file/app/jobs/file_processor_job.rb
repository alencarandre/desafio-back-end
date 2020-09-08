class FileProcessorJob < ApplicationJob
  queue_as :processing

  def perform(processing_id: , key: )
    errors = []
    BucketReaderService.(key) do |line, position|
      errors += CnabService::Processor.(processing_id, line, position)
    end

    notify_errors(errors) if errors.present?

    notify_finish
  end

  private

  def notify_errors(errors)
    # TODO notify errors
  end

  def notify_finish
    # TODO notify finish
  end
end
