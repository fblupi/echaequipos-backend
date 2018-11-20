FactoryBot.define do
  factory :v1_match, class: Match do
    association :affiliation, factory: :v1_affiliation
    association :group, factory: :v1_group
    name { Faker::Football.competition }
    date { Faker::Date.forward(30) }
    duration { Faker::Number.between(30, 90) }
    status { 'proposal' }
    min_players { Faker::Number.between(8, 12) }
    max_players { Faker::Number.between(16, 20) }
    location { Faker::Address.city }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end