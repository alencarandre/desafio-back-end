require 'rails_helper'

RSpec.describe CnabProcessorService, type: :model do
  describe '#call' do
    let(:cnab) { FactoryBot.build(:cnab) }

    describe 'when cnab has already processed' do
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

    describe 'when cnab does not processed' do
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

    describe 'when transaction_type does not exist' do
      it('raise not found error') do
        cnab.transaction_type = -10

        expect { described_class.(cnab) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'when store does not exist' do
      it 'creates a store' do
        cnab.store = Faker::Name.unique.name

        expect { described_class.(cnab) }
          .to change { Store.count }
        expect(Store.where(name: cnab.store)).to be_present
      end
    end

    describe 'when store exist' do
      it 'does not create a store' do
        cnab.store = FactoryBot.create(:store).name

        expect { described_class.(cnab) }
          .to_not change { Store.count }
      end
    end

    describe 'when owner does not exist' do
      it 'creates a owner' do
        cnab.owner = Faker::Name.unique.name
        
        expect { described_class.(cnab) }
          .to change { Owner.count }
        expect(Owner.where(name: cnab.owner)).to be_present
      end
    end

    describe 'when owner exist' do
      it 'does not creates a owner' do
        cnab.owner = FactoryBot.create(:owner).name
        
        expect { described_class.(cnab) }
          .to_not change { Owner.count }
        expect(Owner.where(name: cnab.owner)).to be_present
      end
    end

    describe 'when operation type is incoming' do
      it 'saves movement with positive value' do
        cnab.transaction_type = FactoryBot.create(:transaction_type, operation: :incoming).id
        cnab.value = 10

        expect { described_class.(cnab) }
          .to change { Movement.count }

        movement = Movement.where(transaction_hash: cnab.transaction_hash).first

        expect(movement.value).to eq(10.0)
      end
    end

    describe 'when operation type is outgoing' do
      it 'saves movement with negative value' do
        cnab.transaction_type = FactoryBot.create(:transaction_type, operation: :outgoing).id
        cnab.value = 10

        expect { described_class.(cnab) }
          .to change { Movement.count }

        movement = Movement.where(transaction_hash: cnab.transaction_hash).first

        expect(movement.value).to eq(-10.0)
      end
    end
  end
end
