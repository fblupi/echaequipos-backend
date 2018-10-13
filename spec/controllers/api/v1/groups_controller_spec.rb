require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  @user = login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#create' do
    it 'create group' do
      expect((post :create, params: { v1_group: { name: 'Notingan Prisa', location: 'Granada'}}).response_code).to eq(201)
    end

    it 'does not create group w/o name' do
      expect((post :create, params: { v1_group: { location: 'Granada'}}).response_code).to eq(400)
    end
  end
end
