require 'rails_helper'

RSpec.describe Api::V1::Groups::MatchesController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @group = create(:v1_group)
    @other_group = create(:v1_group)
    @another_group = create(:v1_group)
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @group, affiliation_type: 'admin')
    @other_affiliation = create(:v1_affiliation, user: controller.current_v1_user, group: @other_group)
  end

  describe '#create' do
    it 'creates the match' do
      match_params = {
        name: Faker::Sports::Football.competition,
        date: Faker::Date.forward(days: 30),
        duration: Faker::Number.between(from: 30, to: 90),
        min_players: Faker::Number.between(from: 8, to: 12),
        max_players: Faker::Number.between(from: 16, to: 20),
        location: Faker::Address.city
      }
      expect((post :create, params: { group_id: @group, v1_group_matches: match_params }).response_code).to eq(200)
    end

    it 'does not create the match if bad params' do
      expect((post :create, params: { group_id: @group, v1_group_matches: { name: 'test' } }).response_code).to eq(400)
    end

    it 'does not create the match if the user is not admin of the group' do
      expect((post :create, params: { group_id: @other_group }).response_code).to eq(401)
      expect((post :create, params: { group_id: @another_group }).response_code).to eq(401)
    end

    it 'does not create the match if the group does not exist' do
      expect((post :create, params: { group_id: 0 }).response_code).to eq(401)
    end
  end
end
