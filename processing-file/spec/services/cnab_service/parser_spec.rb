require 'rails_helper'

RSpec.describe CnabService::Parser do
  describe '#call' do
    context 'when receive a valid cnab line' do
      let(:transaction_type) { '3' }
      let(:datetime) { '20190301 172712-03:00'.to_datetime }
      let(:value) { 122.0 }
      let(:document) { '84515254073' }
      let(:card) { '6777****1313' }
      let(:owner) { 'MARCOS PERES' }
      let(:store) { 'MERCADO DA AVENIDA' }
      let(:line) { 
        '3201903010000012200845152540736777****1313172712MARCOS PERES  MERCADO DA AVENIDA '
      }

      it 'parse cnab line correctly' do
        cnab = described_class.(line).to_json

        expect(cnab).to eq({
          transaction_type: transaction_type,
          datetime: datetime,
          value: value,
          document: document,
          card: card,
          owner: owner,
          store: store
        }.to_json)
      end
    end

    context 'when receive a invalid cnab line' do
      let(:line) { ' ' * 81}

      it 'returns a invalid cnab' do
        cnab = described_class.(line)

        expect(cnab).to be_invalid
        expect(cnab.errors.full_messages).to eq([
          "Transaction type can't be blank",
          "Document can't be blank",
          "Card can't be blank",
          "Owner can't be blank",
          "Store can't be blank"
        ])
      end
    end
  end
end
