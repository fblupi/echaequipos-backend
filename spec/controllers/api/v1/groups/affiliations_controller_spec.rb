require 'rails_helper'

RSpec.describe Api::V1::Groups::AffiliationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group)
  end

  describe '#index' do
    it 'get affiliation' do
      expect((get :index, params: { group_id: @group.id }).response_code).to eq(200)
    end

    it 'does not get affiliation if the user is not in the groups' do
      expect((get :index, params: { group_id: @other_group }).response_code).to eq(401)
    end

    it 'does not get affiliation if the groups does not exist' do
      expect((get :index, params: { group_id: 0 }).response_code).to eq(400)
    end
  end
end
