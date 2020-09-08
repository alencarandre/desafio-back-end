class QueueProcessorService < ApplicationService
  def initialize(queue_url)
    @sqs_consume_service = SqsConsumeService.new(queue_url)
  end

  def call
    @sqs_consume_service.call do |payload|
      CnabProcessorService.(Cnab.new(payload))
    end
  end
end
