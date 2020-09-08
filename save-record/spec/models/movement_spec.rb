require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject { FactoryBot.build(:movement) }

  context 'validations' do
    it { should validate_presence_of(:transaction_date) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:card) }
    it { should validate_presence_of(:transaction_hash) }
    it { should validate_uniqueness_of(:transaction_hash) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:transaction_type) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:store) }
  end
end
