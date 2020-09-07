require 'rails_helper'

RSpec.describe CnabFilesController, type: :controller do
  describe '#create' do
    context 'when does not upload file' do
      it 'does not create record' do
        expect {
          post :create, params: { cnab_file: { invalid_params: '' } }
        }.to_not change { CnabFile.count }
      end

      it 'does not enqueue to process' do
        expect(Aws::Client).to_not receive(:sqs)

        post :create, params: { cnab_file: { invalid_params: '' } }
      end
    end

    context 'when upload file' do
      let(:sqs_client) { double('sqs_client') }
      let(:file) do
        path = Rails.root.join('spec', 'fixtures', 'cnab.txt')
        fixture_file_upload(path, 'plain/text')
      end
      let(:params) do
        { 
          cnab_file: { file: file } 
        }
      end

      before do
        allow(sqs_client).to receive(:send_message).and_return(nil)
        allow(Aws::Client)
          .to receive(:sqs)
          .and_return(sqs_client)
      end

      it 'creates a new record' do
        expect { post :create, params: params }
          .to change { CnabFile.count }
          .from(0)
          .to(1)
      end

      it 'enqueue file to processing' do
        post :create, params: params

        cnab_file = CnabFile.last
        message = {
          id: cnab_file.id,
          key: cnab_file.file.key
        }.to_json

        expect(sqs_client)
          .to have_received(:send_message)
          .with(
            hash_including(message_body: message)
          )
      end
    end
  end
end
