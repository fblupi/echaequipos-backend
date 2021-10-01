module Api
  module V1
    module Matches
      class PlayersController < ApiController
        include Api::V1::MatchesConcern
        include Api::V1::PlayersConcern

        before_action :load_match_by_match_id, only: [:create]
        before_action :check_match_auth_admin, only: [:create]

        def create
          affiliation = @match.group.affiliations.find(params.require(:v1_match_players)[:affiliation_id])
          return bad_request(message: 'The player already exists.') if @match.players.find_by(affiliation: affiliation)

          @player = Player.create(match: @match, affiliation: affiliation)
          check_valid_player
        end
      end
    end
  end
end
