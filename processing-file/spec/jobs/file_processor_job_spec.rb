require 'rails_helper'

RSpec.describe FileProcessorJob do
  describe '#perform' do
    let(:cnab) {"cnab line one\ncnab line two"}
    let(:s3_client) { double('s3_client') }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV)
        .to receive(:[])
        .with('AWS_BUCKET')
        .and_return('bucket_name')

      objects = { 'key' => double('bucket_object', read: cnab) }
      buckets = { 'bucket_name' => double('bucket', objects: objects) }
      allow(s3_client)
        .to receive(:buckets)
        .and_return(buckets)
      
      allow(Aws::Client)
        .to receive(:s3)
        .and_return(s3_client)
    end

    it 'process all line from cnab file ' do
      expect(CnabService::Processor)
        .to receive(:call)
        .with(99, 'cnab line one', 1)
        .and_return([])
      expect(CnabService::Processor)
        .to receive(:call)
        .with(99, 'cnab line two', 2)
        .and_return([])
      
      subject.perform(processing_id: 99, key: 'key')
    end
  end
end
