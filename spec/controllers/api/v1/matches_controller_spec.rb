require 'rails_helper'

RSpec.describe Api::V1::MatchesController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @another_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
    @other_affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @other_group, affiliation_type: 'normal')
    @match = create(:v1_match, group: @group, affiliation: @affiliation)
    @other_match = create(:v1_match, group: @other_group, affiliation: @other_affiliation)
  end

  describe '#update' do
    it 'updates the match' do
      expect((put :update, params: { id: @match.id, v1_matches: { duration: 2 } }).response_code).to eq(200)
    end

    it 'does not update the match if bad params' do
      expect((put :update, params: { id: @match.id, v1_matches: { duration: -1 } }).response_code).to eq(400)
    end

    it 'does not update the match if the user is not admin of the group' do
      expect((put :update, params: { id: @other_match.id }).response_code).to eq(401)
    end

    it 'does not update the match if the match does not exist' do
      expect((put :update, params: { id: 0 }).response_code).to eq(401)
    end
  end
end
