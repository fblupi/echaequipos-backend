FactoryBot.define do
  factory :v1_group, class: Group do
    name { Faker::Football.team }
    location { Faker::Address.country }
  end
end
