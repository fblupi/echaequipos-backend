require 'rails_helper'

RSpec.describe Api::V1::Groups::AffiliationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group)
  end

  describe '#create' do
    it 'does not create an affiliation if some param is missing' do
      expect((post :create, params: { group_id: @group.id }).response_code).to eq(400)
    end

    it 'does not create an affiliation if you have no access to it' do
      expect((post :create, params: { group_id: 1, v1_group_affiliations: { email: 'test@test.com' } }).response_code).to eq(401)
    end

    it 'does not create an affiliation if the user does not exists or it is currently in the group' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'invitation')
      expect((post :create, params: { group_id: @group.id, v1_group_affiliations: { email: 'fake@test.com' } }).response_code).to eq(400)
      expect((post :create, params: { group_id: @group.id, v1_group_affiliations: { email: @other_user.email } }).response_code).to eq(400)
    end

    it 'creates an affiliation' do
      @group = create(:v1_group)
      @other_user = create(:v1_user)
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
      expect((post :create, params: { group_id: @group.id, v1_group_affiliations: { email: @other_user.email } }).response_code).to eq(200)
    end
  end

  describe '#index' do
    it 'get affiliation' do
      expect((get :index, params: { group_id: @group.id }).response_code).to eq(200)
    end

    it 'does not get affiliation if the user is not in the groups' do
      expect((get :index, params: { group_id: @other_group }).response_code).to eq(401)
    end

    it 'does not get affiliation if the groups does not exist' do
      expect((get :index, params: { group_id: 0 }).response_code).to eq(401)
    end
  end
end
