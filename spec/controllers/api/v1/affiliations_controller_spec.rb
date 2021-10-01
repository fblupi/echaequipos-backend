require 'rails_helper'

RSpec.describe Api::V1::AffiliationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#show' do
    it 'get affiliation' do
      expect((get :index).response_code).to eq(200)
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
      @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group,
                                             affiliation_type: 'invitation')
      expect((put :update, params: { id: @affiliation.id }).response_code).to eq(200)
    end
  end
end
