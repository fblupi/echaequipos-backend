require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#update_device_token' do
    it 'update user device token' do
      expect((post :update_device_token, params: { v1_users_update_device_token: { device_token: '123456' }}).response_code).to eq(200)
    end
  end
end
