FactoryBot.define do
  factory :v1_position, class: Position do
    name_en { 'Defensive Midfielder' }
    name_es { 'Centrocampista Defensivo' }
    abbr_en { 'DMF' }
    abbr_es { 'CD' }
  end
end