require 'rails_helper'

RSpec.describe CnabService::Processor do
  describe '#call' do
    context 'when receive a invalid line' do
      it 'does not enqueue to save' do
        expect(Aws::Client).to_not receive(:sqs)

        described_class.(1, 'invalid line', 1)
      end

      it 'returns an error' do
        errors = described_class.(1, 'invalid line', 1)

        expect(errors.size).to be(1)
      end
    end

    context 'when receive a valid line' do
      context 'when parsed cnab is invalid' do
        let(:line) { ' ' * 81 }

        it 'does not enqueue to save' do
          expect(Aws::Client).to_not receive(:sqs)
  
          described_class.(1, line, 1)
        end

        it 'returns an error' do
          errors = described_class.(1, line, 1)
  
          expect(errors.size).to be(5)
        end
      end

      context 'when parsed cnab is valid' do
        let(:sqs_client) { double('Aws::Client.sqs', send_message: nil) }
        let(:line) { 
          '3201903010000012200845152540736777****1313172712MARCOS PERES  MERCADO DA AVENIDA '
        }

        before do
          allow(Aws::Client).to receive(:sqs).and_return(sqs_client)
        end

        it 'enqueue cnab to save' do
          message = {
            transaction_type: '3',
            datetime: '20190301 172712-03:00'.to_datetime,
            value: 122.0,
            document: '84515254073',
            card: '6777****1313',
            owner: 'MARCOS PERES',
            store: 'MERCADO DA AVENIDA',
            processing_id: 1,
          }.to_json

          expect(sqs_client)
            .to receive(:send_message)
            .with(
              queue_url: described_class::SAVE_DATA_QUEUE_URL, 
              message_body: message
            )
            .and_return(nil)

          errors = described_class.(1, line, 1)
        end

        it 'does not return error' do
          errors = described_class.(1, line, 1)
  
          expect(errors.size).to be(0)
        end
      end
    end
  end
end
