require 'rails_helper'

RSpec.describe CnabFileService::Importer do
  let(:file) do
    path = Rails.root.join('spec', 'fixtures', 'cnab.txt')
    fixture_file_upload(path, 'plain/text')
  end
  let(:params) do 
    cnab_file = { file: file }
    permitted_values = double(permit: cnab_file )
    params = double(require: permitted_values)

    allow(params)
      .to receive(:[])
      .with(:cnab_file)
      .and_return(cnab_file)

    params
  end

  describe '#call' do
    it 'creates cnab_file with imported status' do
      cnab_file = described_class.(params)

      expect(cnab_file).to be_persisted
      expect(cnab_file.status).to be_imported
    end

    it 'saves file in bucket' do
      cnab_file = described_class.(params)
      expect(cnab_file.file).to be_present
      expect(cnab_file.file).to be_attached
    end
  end
end
