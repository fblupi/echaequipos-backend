module Api
  module V1
    module Matches
      class FinishesController < ApiController
        include Api::V1::MatchesConcern

        before_action :load_match_by_match_id, only: [:update]
        before_action :check_match_auth_admin, only: [:update]

        def update
          @match.finish
        rescue ActiveRecord::RecordInvalid => error
          error_request(message: error.message)
        end
      end
    end
  end
end
