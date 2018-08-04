module Api
  module V1
    class PasswordsController < ::Devise::PasswordsController
      protect_from_forgery
      respond_to :json
    end
  end
end