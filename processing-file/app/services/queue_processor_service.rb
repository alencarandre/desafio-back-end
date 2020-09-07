class QueueProcessorService < ApplicationService
  def initialize(queue_url)
    @sqs_consume_service = SqsConsumeService.new(queue_url)
  end

  def call
    @sqs_consume_service.call do |processing_id, key|
      FileProcessorJob.perform_now(
        processing_id: processing_id,
        key: key
      )
    end
  end
end
