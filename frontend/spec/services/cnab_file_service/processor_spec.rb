require 'rails_helper'

RSpec.describe CnabFileService::Processor do
  describe '#call' do
    let(:sqs_client) { double('sqs_client') }
    let(:cnab_file) { FactoryBot.create(:cnab_file) }

    before do
      file = double(key: 'key')
      allow(cnab_file).to receive(:file).and_return(file)

      allow(sqs_client).to receive(:send_message).and_return(nil)
      allow(Aws::Client)
        .to receive(:sqs)
        .and_return(sqs_client)
    end

    it 'enqueues file to processing' do
      message = {
        id: cnab_file.id,
        key: 'key'
      }.to_json

      expect(sqs_client)
        .to receive(:send_message)
        .with(
          queue_url: described_class::PROCESSING_QUEUE_URL, 
          message_body: message
        )

      described_class.(cnab_file)
    end

    it 'changes status from imported to processing' do
      expect { described_class.(cnab_file) }
        .to change { cnab_file.reload.status }
        .from("imported")
        .to("processing")
    end

    it 'returns cnab file model' do
      expect(described_class.(cnab_file)).to be(cnab_file.reload)
    end
  end
end
