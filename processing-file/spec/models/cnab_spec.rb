require 'rails_helper'

RSpec.describe Cnab, type: :model do
  it { should validate_presence_of(:transaction_type) }
  it { should validate_presence_of(:datetime) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:card) }
  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:store) }
end
