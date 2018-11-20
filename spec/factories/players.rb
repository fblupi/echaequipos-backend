FactoryBot.define do
  factory :v1_player, class: Player do
    association :affiliation, factory: :v1_affiliation
    association :match, factory: :v1_match
    attendance { false }
  end
end