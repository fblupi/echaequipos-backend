require 'rails_helper'

RSpec.describe Api::V1::Matches::PlayersController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @another_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
    @partner_affiliation = create(:v1_affiliation, group: @group)
    @other_affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @other_group, affiliation_type: 'admin')
    @another_affiliation = create(:v1_affiliation, group: @another_group, affiliation_type: 'admin')
    @match = create(:v1_match, group: @group, affiliation: @affiliation, min_players: 1, max_players: 2)
    @other_match = create(:v1_match, group: @other_group, affiliation: @other_affiliation)
    @another_match = create(:v1_match, group: @another_group, affiliation: @another_affiliation)
    @partner_player = create(:v1_player, match: @match, affiliation: @partner_affiliation)
  end

  describe '#create' do
    it 'creates the player' do
      expect((post :create, params: { match_id: @match.id, v1_match_players: { affiliation_id: @affiliation.id } }).response_code).to eq(200)
    end

    it 'does not create the player if no affiliation provided' do
      expect((post :create, params: { match_id: @match.id }).response_code).to eq(400)
    end

    it 'does not create the player if invalid affiliation provided' do
      expect((post :create, params: { match_id: @match.id, v1_match_players: { affiliation_id: 0 } }).response_code).to eq(401)
    end

    it 'does not create the player if affiliation from another group provided' do
      expect((post :create, params: { match_id: @match.id, v1_match_players: { affiliation_id: @other_affiliation.id } }).response_code).to eq(401)
    end

    it 'does not create the player if user is not admin' do
      expect((post :create, params: { match_id: @another_match.id, v1_match_players: { affiliation_id: @another_affiliation.id } }).response_code).to eq(401)
    end

    it 'does not create the player if there is already a player with the same affiliation' do
      expect((post :create, params: { match_id: @match.id, v1_match_players: { affiliation_id: @partner_affiliation.id } }).response_code).to eq(400)
    end
  end
end
