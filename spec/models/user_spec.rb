require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'email is required and must be unique over type' do
      expect { User.create!(email: 'test@test.com', password: '123456') }.to change(User, :count).by(1)
      expect { User.create!(password: '123456') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { User.create!(email: 'test@test.com', password: '123456') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
