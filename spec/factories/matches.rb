FactoryBot.define do
  factory :v1_match, class: Match do
    association :affiliation, factory: :v1_affiliation
    association :group, factory: :v1_group
    name { Faker::Sports::Football.competition }
    date { Faker::Date.forward(days: 30) }
    duration { Faker::Number.between(from: 30, to: 90) }
    status { Match::INITIAL_STATUS }
    min_players { Faker::Number.between(from: 8, to: 12) }
    max_players { Faker::Number.between(from: 16, to: 20) }
    location { Faker::Address.city }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end