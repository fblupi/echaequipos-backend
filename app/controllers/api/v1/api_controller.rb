module Api
  module V1
    class ApiController < ApplicationController
      protect_from_forgery
      before_action :authenticate_v1_user!

      respond_to :json
      rescue_from ActiveRecord::RecordNotFound do
        error_response(:unauthorized, 'You need to sign in or sign up before continuing.')
      end

      private

      def current_user
        current_user ||= current_v1_user
      end

      def bad_request(message: 'Bad request.')
        error_response(:bad_request, message)
      end

      def unauthorized(message: 'Unauthorized.')
        error_response(:unauthorized, message)
      end

      def error_response(status, message)
        self.status = status
        self.content_type = 'application/json'
        self.response_body = { error: message }.to_json
      end
    end
  end
end