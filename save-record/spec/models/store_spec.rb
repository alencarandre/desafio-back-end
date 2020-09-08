require 'rails_helper'

RSpec.describe Store, type: :model do
  subject { FactoryBot.build(:store) }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end