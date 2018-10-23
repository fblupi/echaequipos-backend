require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'email is required and must be unique' do
      expect { User.create!(email: 'test@test.com', password: '123456') }.to change(User, :count).by(1)
      expect { User.create!(password: '123456') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { User.create!(email: 'test@test.com', password: '123456') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'group creation' do
    before(:each) do
      @user = create(:v1_user)
    end

    it 'does not create a group if the mandatory params are missing' do
      expect(@user.create_group).to be_nil
      expect(@user.create_group(location: 'Granada')).to be_nil
    end

    it 'creates a group' do
      expect(Affiliation.count).to eq 0
      expect(Group.count).to eq 0

      @user.create_group(name: 'Notingan Prisa', location: 'Granada')

      expect(Affiliation.count).to eq 1
      expect(Group.count).to eq 1
    end
  end

  describe 'check affiliations' do
    before(:each) do
      @user = create(:v1_user)
      create(:v1_affiliation, user: @user, group: create(:v1_group), affiliation_type: 'invitation')
      create(:v1_affiliation, user: @user, group: create(:v1_group), affiliation_type: 'invitation')
      create(:v1_affiliation, user: @user, group: create(:v1_group), affiliation_type: 'normal')
      create(:v1_affiliation, user: @user, group: create(:v1_group), affiliation_type: 'normal')
      create(:v1_affiliation, user: @user, group: create(:v1_group), affiliation_type: 'admin')
    end

    it 'checks current affiliations' do
      expect(@user.current_affiliations.count).to be(3)
    end

    it 'check current invitations' do
      expect(@user.invitation_affiliations.count).to be(2)
    end
  end
end
