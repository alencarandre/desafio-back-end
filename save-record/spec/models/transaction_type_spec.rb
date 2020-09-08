require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  subject { FactoryBot.build(:transaction_type) }

  context 'validations' do
    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:operation) }
    it { should validate_presence_of(:description) }
  end
end
