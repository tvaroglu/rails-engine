FactoryBot.define do
  factory :invoice do
    status { Faker::Verb.past }
  end
end
