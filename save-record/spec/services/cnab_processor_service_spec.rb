require 'rails_helper'

RSpec.describe CnabProcessorService, type: :model do
  describe '#call' do
    context 'when cnab has already processed' do
      let!(:cnab) { FactoryBot.build(:cnab) }

      before do
        allow(cnab)
          .to receive(:transaction_hash)
          .and_return('transaction_hash')
        
        FactoryBot.create(:movement, transaction_hash: 'transaction_hash')
      end

      it 'does not create new movement' do
        expect { described_class.(cnab) }
          .to_not change { Movement.count }
      end
    end

    context 'when cnab does not processed' do
      let!(:cnab) { FactoryBot.build(:cnab) }

      before do
        allow(cnab)
          .to receive(:transaction_hash)
          .and_return(SecureRandom.hex)
       end

      it 'creates new movement' do
        expect { described_class.(cnab) }
          .to change { Movement.count }
        expect(Movement.where(transaction_hash: cnab.transaction_hash))
          .to be_present
      end
    end

    context 'when transaction_type does not exist' do
      let!(:cnab) { FactoryBot.build(:cnab, transaction_type: -10) }

      it('raise not found error') do
        expect { described_class.(cnab) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when store does not exist and owner does not exist' do
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab, 
            store: Faker::Name.unique.name, 
            owner: Faker::Name.unique.name
          ) 
      }

      it 'creates a store associated to new owner' do
        expect { described_class.(cnab) }
          .to change { Store.count }

        store = Store.where(name: cnab.store).first

        expect(store).to be_present
        expect(store.owner.name).to eq(cnab.owner)
      end
    end

    context 'when store does not exist and owner exists' do
      let(:owner) { FactoryBot.create(:owner) }
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab,
            store: Faker::Name.unique.name,
            owner: owner.name,
          )
      }

      it 'creates a store associated to onwer' do
        expect { described_class.(cnab) }
          .to change { Store.count }

        store = Store.where(name: cnab.store).first

        expect(store).to be_present
        expect(store.owner.name).to eq(cnab.owner)
      end
    end


    context 'when store exist and owner does not exists' do
      let(:store) { FactoryBot.create(:store) }
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab,
            store: store.name,
            owner: Faker::Name.unique.name,
          )
      }

      it 'creates a store associated to onwer' do
        expect { described_class.(cnab) }
          .to change { Store.count }

        store = Store
          .joins(:owner)
          .where(name: cnab.store, owners: { name: cnab.owner })
          .first

        expect(store).to be_present
      end
    end

    context 'when store exist and owner exists' do
      let(:store) { FactoryBot.create(:store) }
      let(:owner) { store.owner }
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab,
            store: store.name,
            owner: owner.name,
          )
      }
      it 'does not create a store' do
        expect { described_class.(cnab) }
          .to_not change { Store.count }
      end
    end

    context 'when owner does not exist' do
      let!(:cnab) { FactoryBot.build(:cnab, owner: Faker::Name.unique.name) }

      it 'creates a owner' do
        expect { described_class.(cnab) }
          .to change { Owner.count }
        expect(Owner.where(name: cnab.owner)).to be_present
      end
    end

    context 'when owner exist' do
      let(:owner) { FactoryBot.create(:owner) }
      let!(:cnab) { FactoryBot.build(:cnab, owner: owner.name) }

      it 'does not creates a owner' do
        expect { described_class.(cnab) }
          .to_not change { Owner.count }
        expect(Owner.where(name: cnab.owner)).to be_present
      end
    end

    context 'when operation type is incoming' do
      let(:transaction_type) { FactoryBot.create(:transaction_type, operation: :incoming) }
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab, 
            transaction_type: transaction_type.id,
            value: 10,
          ) 
      }

      it 'saves movement with positive value' do
        expect { described_class.(cnab) }
          .to change { Movement.count }

        movement = Movement.where(transaction_hash: cnab.transaction_hash).first

        expect(movement.value).to eq(10.0)
      end
    end

    context 'when operation type is outgoing' do
      let(:transaction_type) { FactoryBot.create(:transaction_type, operation: :outgoing) }
      let!(:cnab) { 
        FactoryBot
          .build(
            :cnab, 
            transaction_type: transaction_type.id,
            value: 10,
          ) 
      }

      it 'saves movement with negative value' do
        expect { described_class.(cnab) }
          .to change { Movement.count }

        movement = Movement.where(transaction_hash: cnab.transaction_hash).first

        expect(movement.value).to eq(-10.0)
      end
    end
  end
end
