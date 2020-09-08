require 'rails_helper'

RSpec.describe QueueProcessorService do
  describe '#call' do
    let(:sqs_consume_service) { double }

    before do
      allow(SqsConsumeService)
        .to receive(:new)
        .and_return(sqs_consume_service)

      allow(sqs_consume_service)
        .to receive(:call) do |&block|
          block.call('processing_id', 'bucket_key')
        end
    end

    it 'perform received message to job' do
      expect(FileProcessorJob)
        .to receive(:perform_now)
        .with(
          processing_id: 'processing_id',
          key: 'bucket_key'
        )

      QueueProcessorService.('valid_queue_url_where')
    end
  end
end
