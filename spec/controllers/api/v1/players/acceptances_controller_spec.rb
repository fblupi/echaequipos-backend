require 'rails_helper'

RSpec.describe Api::V1::Players::AcceptancesController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
    @other_affiliation = create(:v1_affiliation, group: @group)
    @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1, max_players: 2)
    @player = create(:v1_player, affiliation: @affiliation, match: @match)
    @other_player = create(:v1_player, affiliation: @other_affiliation, match: @match)
  end

  describe '#create' do
    it 'accept the invitation to the match' do
      expect((put :update, params: { player_id: @player.id }).response_code).to eq(200)
    end

    it 'does not confirm the invitation if the player does not belong to the user' do
      expect((put :update, params: { player_id: @other_player.id }).response_code).to eq(401)
    end

    it 'does not accept the invitation if no player provided' do
      expect((put :update, params: { player_id: 0 }).response_code).to eq(401)
    end
  end
end
