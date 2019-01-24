module Api
  module V1
    module Matches
      class FinishesController < BaseController
        before_action :load_match, only: [:update]
        before_action :check_auth_admin, only: [:update]

        def update
          @match.finish
        rescue ActiveRecord::RecordInvalid => error
          error_request(message: error.message)
        end
      end
    end
  end
end