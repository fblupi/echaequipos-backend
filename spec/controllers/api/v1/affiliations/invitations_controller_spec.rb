require 'rails_helper'

RSpec.describe Api::V1::Affiliations::InvitationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#create' do
    it 'does not create an affiliation if some param is missing' do
      expect((post :create, params: { v1_affiliations_invitations: { email: 'test@test.com' } }).response_code).to eq(400)
      expect((post :create, params: { v1_affiliations_invitations: { group_id: 1 } }).response_code).to eq(400)
      expect((post :create).response_code).to eq(400)
    end

    it 'does not create an affiliation if you have no access to it' do
      expect((post :create, params: { v1_affiliations_invitations: { group_id: 1, email: 'test@test.com' } }).response_code).to eq(401)
    end

    it 'does not create an affiliation if the user does not exists or it is currently in the group' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'invitation')
      expect((post :create, params: { v1_affiliations_invitations: { group_id: @group.id, email: 'fake@test.com' } }).response_code).to eq(400)
      expect((post :create, params: { v1_affiliations_invitations: { group_id: @group.id, email: @other_user.email } }).response_code).to eq(400)
    end

    it 'creates an affiliation' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      expect((post :create, params: { v1_affiliations_invitations: { group_id: @group.id, email: @other_user.email } }).response_code).to eq(200)
    end
  end

  describe '#update' do
    it 'does not update an affiliation if you have already accepted it' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'normal')
      expect((put :update, params: { id: @affiliation.id }).response_code).to eq(400)
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(401)
    end

    it 'does not update an affiliation if you have no permission' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'invitation')
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(401)
    end

    it 'updates an affiliation' do
      @group = create(:v1_group)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'invitation')
      expect((put :update, params: { id: @affiliation.id }).response_code).to eq(200)
    end
  end
end