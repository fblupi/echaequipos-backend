require 'rails_helper'

RSpec.describe Api::V1::Affiliations::InvitationsController, type: :controller do
  login_v1_user

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end
end