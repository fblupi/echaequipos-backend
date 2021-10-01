FactoryBot.define do
  factory :v1_affiliation, class: Affiliation do
    association :user, factory: :v1_user
    association :group, factory: :v1_group
    affiliation_type { 'normal' }
  end
end
