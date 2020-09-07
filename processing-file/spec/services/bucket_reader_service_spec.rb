require 'rails_helper'

RSpec.describe BucketReaderService do
  describe '#call' do
    let(:cnab) {"line1\nline2\n\n"}
    let(:s3_client) { double('s3_client') }

    before do
      allow(s3_client)
        .to receive_message_chain(:get_object, :body, read: cnab)

      allow(Aws::Client)
        .to receive(:s3)
        .and_return(s3_client)
    end

    it 'read the bucket and call block for each line' do
      processed = []
      BucketReaderService.('key') do |line, position|
        processed.push("#{line}_#{position}")
      end

      expect(processed)
        .to eq([ 'line1_1', 'line2_2' ])
    end
  end
end
