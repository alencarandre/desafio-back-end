FactoryBot.define do
  factory :store do
    name { Faker::Name.unique.name  }
  end
end
