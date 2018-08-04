module Api
  module V1
    class ApiController < ApplicationController
      protect_from_forgery
      before_action :authenticate_v1_user!

      respond_to :json
      rescue_from ActiveRecord::RecordNotFound do
        self.status = :unauthorized
        self.content_type = 'application/json'
        self.response_body = { error: 'You need to sign in or sign up before continuing.' }.to_json
      end

      def current_user
        current_user ||= current_v1_user
      end
    end
  end
end