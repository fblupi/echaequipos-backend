class Position < ApplicationRecord
  validates :name_es, :name_en, :abbr_en, :abbr_es, presence: true

  has_field_localization %w[name abbr]

  has_and_belongs_to_many :affiliations
end
