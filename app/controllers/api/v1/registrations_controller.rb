module Api
  module V1
    class RegistrationsController < ::Devise::RegistrationsController
      protect_from_forgery
      respond_to :json
    end
  end
end
