require 'rails_helper'

RSpec.describe Api::V1::PositionsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#index' do
    it 'index positions' do
      expect((get :index).response_code).to eq(200)
    end
  end
end