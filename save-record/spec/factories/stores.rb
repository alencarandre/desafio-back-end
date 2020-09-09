FactoryBot.define do
  factory :store do
    name { Faker::Name.unique.name  }
    owner
  end
end
