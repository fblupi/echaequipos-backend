require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'validations' do
    it 'name_en, name_es, abbr_en and abbr_es are required' do
      expect do
        Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo', abbr_en: 'DMF',
                         abbr_es: 'CD')
      end.to change(Position, :count).by(1)
      expect do
        Position.create!(name_es: 'Centrocampista Defensivo', abbr_en: 'DMF',
                         abbr_es: 'CD')
      end.to raise_error(ActiveRecord::RecordInvalid)
      expect do
        Position.create!(name_en: 'Defensive Midfielder', abbr_en: 'DMF',
                         abbr_es: 'CD')
      end.to raise_error(ActiveRecord::RecordInvalid)
      expect do
        Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo',
                         abbr_es: 'CD')
      end.to raise_error(ActiveRecord::RecordInvalid)
      expect do
        Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo',
                         abbr_en: 'DMF')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
