require 'rails_helper'

RSpec.describe SqsConsumeService do
  describe '#call' do
    let(:sqs_client) { double('sqs_client') }
    let(:messages) do
      [
        double(receipt_handle: 'handle1', body: { data: 'to process' }.to_json),
        double(receipt_handle: 'handle2', body: { another: 'data' }.to_json),
      ]
    end

    before do
      allow(sqs_client)
        .to receive(:delete_message)
        .and_return(nil)
      allow(sqs_client)
        .to receive(:receive_message)
        .and_return(
          double(messages: messages)
        )
      allow(Aws::Client)
        .to receive(:sqs)
        .and_return(sqs_client)
    end

    it 'calls block for each message received' do
      processed = []
      SqsConsumeService.('valid_queue_url_here') do |payload|
        processed.push(payload)
      end

      expect(processed)
        .to eq([
          { 'data' => 'to process' },
          { 'another' => 'data' }
        ])
    end

    it 'delete message after processing' do
      expect(sqs_client)
        .to receive(:delete_message)
        .with(
          queue_url: 'valid_queue_url_here',
          receipt_handle: 'handle1'
        )
        .once
      expect(sqs_client)
        .to receive(:delete_message)
        .with(
          queue_url: 'valid_queue_url_here',
          receipt_handle: 'handle2'
        )
        .once

      SqsConsumeService.('valid_queue_url_here') do |id, key|
        'success'
      end
    end
  end
end
