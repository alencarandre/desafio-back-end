require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject { FactoryBot.build(:owner) }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
