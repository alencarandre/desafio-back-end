require 'rails_helper'

RSpec.describe QueueProcessorService do
  describe '#call' do
    let(:sqs_consume_service) { double }
    let(:cnab) { FactoryBot.build(:cnab) }

    before do
      allow(SqsConsumeService)
        .to receive(:new)
        .and_return(sqs_consume_service)
      
      allow(Cnab)
        .to receive(:new)
        .with({ transaction_type: 99 })
        .and_return(cnab)

      allow(sqs_consume_service)
        .to receive(:call) do |&block|
          block.call({ transaction_type: 99 })
        end
    end

    it 'perform received message to job' do
      expect(CnabProcessorService)
        .to receive(:call)
        .with(cnab)

      QueueProcessorService.('valid_queue_url_where')
    end
  end
end
