FactoryBot.define do
  factory :v1_group, class: Group do
    name { Faker::Sports::Football.team }
    location { Faker::Address.country }
  end
end
