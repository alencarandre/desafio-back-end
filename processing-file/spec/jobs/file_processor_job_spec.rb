require 'rails_helper'

RSpec.describe FileProcessorJob do
  describe '#perform' do
    let(:s3_client) { double('s3_client') }

    before do
      allow_any_instance_of(BucketReaderService)
        .to receive(:call) do |&block|
          block.call('valid cnab line', 1)
        end
    end

    it 'process all line from cnab file ' do
      expect(CnabService::Processor)
        .to receive(:call)
        .with(99, 'valid cnab line', 1)
        .and_return([])
      
      subject.perform(processing_id: 99, key: 'key')
    end
  end
end
