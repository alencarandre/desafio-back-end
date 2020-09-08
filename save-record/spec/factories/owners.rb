FactoryBot.define do
  factory :owner do
    name { Faker::Name.unique.name }
  end
end
