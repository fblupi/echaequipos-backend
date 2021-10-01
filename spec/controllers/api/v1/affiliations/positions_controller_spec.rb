require 'rails_helper'

RSpec.describe Api::V1::Affiliations::PositionsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
    @affiliation = create(:v1_affiliation, user: controller.current_v1_user)
    @position = create(:v1_position)
  end

  describe '#show' do
    it 'show positions' do
      expect((get :show, params: { affiliation_id: @affiliation.id }).response_code).to eq(200)
    end
  end

  describe '#update' do
    it 'update positions' do
      expect((put :update,
                  params: { affiliation_id: @affiliation.id,
                            v1_affiliation_positions: { position_ids: [@position.id] } }).response_code).to eq(200)
    end
  end
end
