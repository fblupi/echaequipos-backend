module Api
  module V1
    module MatchesConcern
      include ActiveSupport::Concern

      def load_match
        @match = Match.find_by_id(params[:id])
        bad_request unless @match
      end

      def check_auth_admin
        unauthorized(message: 'You are not an admin of this match.') unless @match&.group&.admin?(current_user)
      end
    end
  end
end
