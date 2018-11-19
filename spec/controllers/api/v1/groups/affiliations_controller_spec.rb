require 'rails_helper'

RSpec.describe Api::V1::Groups::AffiliationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group)
  end

  describe '#show' do
    it 'get affiliation' do
      expect((get :show, params: { id: @group.id }).response_code).to eq(200)
    end

    it 'does not get affiliation if the user is not in the group' do
      expect((get :show, params: { id: @other_group }).response_code).to eq(401)
    end
  end
end
