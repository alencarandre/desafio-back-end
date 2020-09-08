require 'rails_helper'

RSpec.describe Aws::Client, type: :model do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV)
      .to receive(:[])
      .with('AWS_ACCESS_KEY_ID')
      .and_return('AWS_ACCESS_KEY_ID')
    allow(ENV)
      .to receive(:[])
      .with('AWS_SECRET_ACCESS_KEY')
      .and_return('AWS_SECRET_ACCESS_KEY')
    allow(ENV)
      .to receive(:[])
      .with('AWS_REGION')
      .and_return('AWS_REGION')
    allow(ENV)
      .to receive(:[])
      .with('AWS_ENDPOINT')
      .and_return('http://fake.endpoint.com')
  end

  describe '.sqs' do
    it 'instanciates an aws sqs client' do
      sqs_client = double
      expect(Aws::SQS::Client)
        .to receive(:new)
        .with(
          access_key_id: 'AWS_ACCESS_KEY_ID',
          secret_access_key: 'AWS_SECRET_ACCESS_KEY',
          endpoint: 'http://fake.endpoint.com',
          region: 'AWS_REGION',
        )
        .and_return(sqs_client)

      expect(described_class.sqs).to be(sqs_client)
    end
  end
end
