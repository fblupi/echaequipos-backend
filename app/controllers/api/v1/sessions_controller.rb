module Api
  module V1
    class SessionsController < ::Devise::SessionsController
      protect_from_forgery
      respond_to :json, only: [:create]
    end
  end
end
