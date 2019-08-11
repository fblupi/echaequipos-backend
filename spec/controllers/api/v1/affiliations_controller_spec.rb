require 'rails_helper'

RSpec.describe Api::V1::Users::AffiliationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe '#show' do
    it 'get affiliation' do
      expect((get :index).response_code).to eq(200)
    end
  end
end