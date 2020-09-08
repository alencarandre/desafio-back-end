FactoryBot.define do
  factory :transaction_type do
    sequence(:id) { |i| i }
    operation { "incoming" }
    description { "Debit" }
  end
end
