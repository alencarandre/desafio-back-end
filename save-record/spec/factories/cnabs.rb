FactoryBot.define do
  factory :cnab, class: Cnab do
    transaction_type { FactoryBot.create(:transaction_type).id }
    datetime { Time.zone.now }
    value { Random.rand * 1000 }
    document { 'document' }
    card { 'card' }
    owner { FactoryBot.create(:owner).name }
    store { FactoryBot.create(:store).name }
    processing_id { 1 }
  end
end
