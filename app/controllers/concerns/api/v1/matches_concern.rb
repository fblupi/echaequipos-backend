module Api
  module V1
    module MatchesConcern
      include ActiveSupport::Concern

      def load_match_by_id
        load_match(:id)
      end

      def load_match_by_match_id
        load_match(:match_id)
      end

      def check_valid_match
        bad_request(message: "Bad params: #{@match.errors.full_messages.join('. ')}") unless @match.valid?
      end

      def check_match_auth_admin
        unauthorized(message: 'You are not an admin of this match.') unless @match&.user_admin?(current_user)
      end

      def match_params
        default_match_params(:v1_match)
      end

      def group_match_params
        default_match_params(:v1_group_matches)
      end

      private

      def default_match_params(key)
        params.require(key).permit(:name, :date, :duration, :min_players, :max_players, :location, :latitude, :longitude)
      end

      def load_match(param)
        @match = Match.find(params[param])
      end
    end
  end
end
