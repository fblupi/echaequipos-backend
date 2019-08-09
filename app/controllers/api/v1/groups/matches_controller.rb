module Api
  module V1
    module Groups
      class MatchesController < ApiController
        include Api::V1::GroupsConcern

        before_action :load_group, only: [:create, :update]
        before_action :load_match, only: [:update]
        before_action :check_admin_auth, only: [:create, :update]

        def create
          @match = Match.create(match_params.merge(creator: @group.affiliation(current_user), group: @group, status: Match::INITIAL_STATUS))
          check_bad_request
        end

        def update
          @match.update(match_params)
          check_bad_request
        end

        private

        def check_bad_request
          bad_request(message: "Bad params: #{@match.errors.full_messages.join('. ')}") unless @match.valid?
        end

        def match_params
          params.require(:v1_groups_matches).permit(:name, :date, :duration, :min_players, :max_players, :location, :latitude, :longitude)
        end
      end
    end
  end
end
