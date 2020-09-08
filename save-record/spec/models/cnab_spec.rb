require 'rails_helper'

RSpec.describe Cnab, type: :model do
  describe '#transaction_hash' do
    subject do
      Cnab.new(
        transaction_type: 10,
        datetime: DateTime.parse('2500-12-31'),
        value: 123,
        document: 'document',
        card: 'card',
        owner: 'Ash',
        store: 'Pokemon Store',
        processing_id: 1,
      )
    end

    it 'calculate transaction hash' do
      expect(subject.transaction_hash)
        .to eq('af7b409a44a80eec2acbdf96697413c6ea03eda25eee2975fd0ad636497830c6')
    end
  end
end
