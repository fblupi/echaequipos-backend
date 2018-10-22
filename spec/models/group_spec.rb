require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validations' do
    it 'name is required' do
      expect { Group.create!(name: 'Test', location: 'Granada') }.to change(Group, :count).by(1)
      expect { Group.create!(location: 'Granada') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'exist user' do
    before(:each) do
      @user = build(:v1_user)
      @other_user = build(:v1_user)
      @group = build(:v1_group)
      @affiliation = Affiliation.create(group: @group, user: @user, affiliation_type: 'admin')
    end

    it 'exists user' do
      expect(@group.exist_user?(@user)).to be true
    end

    it 'does not exist user' do
      expect(@group.exist_user?(@other_user)).to be false
    end
  end

  describe 'check types' do
    before(:each) do
      @user_invitation = build(:v1_user)
      @user_normal = build(:v1_user)
      @user_normal_other = build(:v1_user)
      @user_normal_and_other = build(:v1_user)
      @user_founder = build(:v1_user)
      @user_admin = build(:v1_user)
      @group = build(:v1_group)

      Affiliation.create(group: @group, user: @user_invitation, affiliation_type: 'invitation')
      Affiliation.create(group: @group, user: @user_normal, affiliation_type: 'normal')
      Affiliation.create(group: @group, user: @user_normal_other, affiliation_type: 'normal')
      Affiliation.create(group: @group, user: @user_normal_and_other, affiliation_type: 'normal')
      Affiliation.create(group: @group, user: @user_founder, affiliation_type: 'admin')
      Affiliation.create(group: @group, user: @user_admin, affiliation_type: 'admin')
    end

    it 'checks invitation' do
      expect(@group.invitation?(@user_invitation)).to be true
      expect(@group.invitation?(@user_normal)).to be false
      expect(@group.invitation?(@user_normal_other)).to be false
      expect(@group.invitation?(@user_normal_and_other)).to be false
      expect(@group.invitation?(@user_founder)).to be false
      expect(@group.invitation?(@user_admin)).to be false
    end

    it 'checks normal' do
      expect(@group.normal?(@user_invitation)).to be false
      expect(@group.normal?(@user_normal)).to be true
      expect(@group.normal?(@user_normal_other)).to be true
      expect(@group.normal?(@user_normal_and_other)).to be true
      expect(@group.normal?(@user_founder)).to be false
      expect(@group.normal?(@user_admin)).to be false
    end

    it 'checks admin' do
      expect(@group.admin?(@user_invitation)).to be false
      expect(@group.admin?(@user_normal)).to be false
      expect(@group.admin?(@user_normal_other)).to be false
      expect(@group.admin?(@user_normal_and_other)).to be false
      expect(@group.admin?(@user_founder)).to be true
      expect(@group.admin?(@user_admin)).to be true
    end
  end

  describe 'invite user' do
    before(:each) do
      @user = build(:v1_user)
      @group = build(:v1_group)
    end

    it 'invites user' do
      expect(Affiliation.count).to be 0
      expect(@group.exist_user?(@user)).to be false
      affiliation = @group.invite_user(@user)
      expect(affiliation.affiliation_type).to eq 'invitation'
      expect(@group.exist_user?(@user)).to be true
      expect(@group.invite_user(@user)).to be nil
    end
  end
end