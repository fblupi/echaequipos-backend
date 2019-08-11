module Api
  module V1
    class MatchesController < ApiController
      include Api::V1::MatchesConcern

      before_action :load_match_by_id, only: [:update]
      before_action :check_match_auth_admin, only: [:update]

      def update
        @match.update(match_params)
        check_valid_match
      end
    end
  end
end
