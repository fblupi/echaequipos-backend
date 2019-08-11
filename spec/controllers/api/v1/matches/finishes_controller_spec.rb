require 'rails_helper'

RSpec.describe Api::V1::Matches::FinishesController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @another_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
    @other_affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @other_group, affiliation_type: 'admin')
    @another_affiliation = create(:v1_affiliation, group: @another_group, affiliation_type: 'admin')
    @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1, max_players: 2)
    @other_match = create(:v1_match, group: @other_group, affiliation: @other_affiliation)
    @another_match = create(:v1_match, group: @another_group, affiliation: @another_affiliation)
    @other_affiliation.downgrade_normal
  end

  describe '#create' do
    it 'finishes the match' do
      expect((put :update, params: { match_id: @match }).response_code).to eq(200)
    end

    it 'does not finish the match if the user is not admin of the group' do
      expect((put :update, params: { match_id: @other_match }).response_code).to eq(401)
      expect((put :update, params: { match_id: @another_match }).response_code).to eq(401)
    end

    it 'does not finish the match if the match does not exist' do
      expect((put :update, params: { match_id: 0 }).response_code).to eq(401)
    end
  end
end