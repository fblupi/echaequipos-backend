require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'name is required' do
      expect { Group.create!(name: 'Test', location: 'Granada') }.to change(Group, :count).by(1)
      expect { Group.create!(location: 'Granada') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end