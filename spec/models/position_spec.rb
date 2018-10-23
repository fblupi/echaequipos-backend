require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'validations' do
    it 'name_en, name_es, abbr_en and abbr_es are required' do
      expect { Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo', abbr_en: 'DMF', abbr_es: 'CD') }.to change(Position, :count).by(1)
      expect { Position.create!(name_es: 'Centrocampista Defensivo', abbr_en: 'DMF', abbr_es: 'CD') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Position.create!(name_en: 'Defensive Midfielder', abbr_en: 'DMF', abbr_es: 'CD') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo', abbr_es: 'CD') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Position.create!(name_en: 'Defensive Midfielder', name_es: 'Centrocampista Defensivo', abbr_en: 'DMF') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end