require 'rails_helper'

RSpec.describe Api::V1::Affiliations::DowngradesController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @other_user = create(:v1_user)
    @group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
  end

  describe '#update' do
    it 'downgrades admin affiliation' do
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'admin')
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(200)
    end

    it 'does not downgrade invitation affiliation' do
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'invitation')
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(400)
    end

    it 'does not downgrade normal affiliation' do
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @group, affiliation_type: 'normal')
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(400)
    end

    it 'does not upgrade other group affiliation' do
      @other_group = create(:v1_group)
      @other_affiliation = create(:v1_affiliation, user: @other_user, group: @other_group, affiliation_type: 'admin')
      expect((put :update, params: { id: @other_affiliation.id }).response_code).to eq(401)
    end
  end
end