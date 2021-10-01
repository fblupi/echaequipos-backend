require 'rails_helper'

RSpec.describe Affiliation, type: :model do
  describe 'validations' do
    before(:each) do
      @user = create(:v1_user)
      @other_user = create(:v1_user)
      @group = create(:v1_group)
    end

    it 'affiliation_type is required' do
      expect { Affiliation.create!(user: @user, group: @group) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'user is required' do
      expect do
        Affiliation.create!(group: @group, affiliation_type: 'normal')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'group is required' do
      expect do
        Affiliation.create!(user: @user, affiliation_type: 'normal')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'uniqueness of pair user group required' do
      expect do
        Affiliation.create!(user: @user, group: @group, affiliation_type: 'normal')
      end.to change(Affiliation, :count).by(1)
      expect do
        Affiliation.create!(user: @other_user, group: @group,
                            affiliation_type: 'normal')
      end.to change(Affiliation, :count).by(1)
      expect do
        Affiliation.create!(user: @user, group: @group,
                            affiliation_type: 'normal')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'affiliation types' do
    before(:each) do
      @affiliation_invitation = create(:v1_affiliation, affiliation_type: 'invitation')
      @affiliation_normal = create(:v1_affiliation, affiliation_type: 'normal')
      @affiliation_admin = create(:v1_affiliation, affiliation_type: 'admin')
    end

    it 'checks invitation' do
      expect(@affiliation_invitation.invitation?).to be true
      expect(@affiliation_normal.invitation?).to be false
      expect(@affiliation_admin.invitation?).to be false
    end

    it 'checks normal' do
      expect(@affiliation_invitation.normal?).to be false
      expect(@affiliation_normal.normal?).to be true
      expect(@affiliation_admin.normal?).to be false
    end

    it 'checks admin' do
      expect(@affiliation_invitation.admin?).to be false
      expect(@affiliation_normal.admin?).to be false
      expect(@affiliation_admin.admin?).to be true
    end
  end

  describe 'change types' do
    before(:each) do
      @affiliation = create(:v1_affiliation)
    end

    it 'accepts invitation' do
      @affiliation.accept_invitation
      expect(@affiliation.affiliation_type).to eq 'normal'
    end

    it 'upgrades admin' do
      @affiliation.upgrade_admin
      expect(@affiliation.affiliation_type).to eq 'admin'
    end

    it 'downgrades admin' do
      @affiliation.downgrade_normal
      expect(@affiliation.affiliation_type).to eq 'normal'
    end
  end
end
