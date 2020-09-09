require 'rails_helper'

RSpec.describe Store, type: :model do
  subject { FactoryBot.build(:store) }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:owner_id).case_insensitive }
  end

  describe '#summary' do
    let(:owner1) { FactoryBot.create(:owner)}
    let(:store1) { FactoryBot.create(:store, owner: owner1) }
    let(:owner2) { FactoryBot.create(:owner)}
    let(:store2) { FactoryBot.create(:store, owner: owner2) }
    let(:transaction_incoming) { FactoryBot.create(:transaction_type, operation: :incoming) }
    let(:transaction_outgoing) { FactoryBot.create(:transaction_type, operation: :outgoing) }

    before do
      FactoryBot.create(
        :movement,
        owner: owner1,
        store: store1,
        transaction_type: transaction_incoming,
        value: 100,
      )
      FactoryBot.create(
        :movement,
        owner: owner1,
        store: store1,
        transaction_type: transaction_outgoing,
        value: -30
      )

      FactoryBot.create(
        :movement,
        owner: owner2,
        store: store2,
        transaction_type: transaction_incoming,
        value: 300,
      )
      FactoryBot.create(
        :movement,
        owner: owner2,
        store: store2,
        transaction_type: transaction_outgoing,
        value: -350
      )
    end

    it 'returns a object with store name, owner name, movementation summarized' do
      expect(described_class.summary.all.as_json).to eq([
        {
          "id" => store1.id,
          "name" => store1.name,
          "owner_name" => owner1.name,
          "total_amount" => 70,
        },
        {
          "id" => store2.id,
          "name" => store2.name,
          "owner_name" => owner2.name,
          "total_amount" => -50,
        }
      ])
    end
  end
end
