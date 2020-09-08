FactoryBot.define do
  factory :movement do
    transaction_type
    transaction_date { Time.zone.now }
    value { Random.rand * 1000 }
    document { "61098263081" }
    card { "5443********8232" }
    owner
    store
    transaction_hash { SecureRandom.hex }
  end
end
