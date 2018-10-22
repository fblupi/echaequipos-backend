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
      @user = build(:v1_user)
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
      @user = build(:v1_user)
      @group_invitation = build(:v1_group)
      @group_invitation_other = build(:v1_group)
      @group_normal = build(:v1_group)
      @group_normal_other = build(:v1_group)
      @group_admin = build(:v1_group)
      Affiliation.create(user: @user, group: @group_invitation, affiliation_type: 'invitation')
      Affiliation.create(user: @user, group: @group_invitation_other, affiliation_type: 'invitation')
      Affiliation.create(user: @user, group: @group_normal, affiliation_type: 'normal')
      Affiliation.create(user: @user, group: @group_normal_other, affiliation_type: 'normal')
      Affiliation.create(user: @user, group: @group_admin, affiliation_type: 'admin')
    end

    it 'checks current affiliations' do
      expect(@user.current_affiliations.count).to be(3)
    end

    it 'check current invitations' do
      expect(@user.invitation_affiliations.count).to be(2)
    end
  end
end
