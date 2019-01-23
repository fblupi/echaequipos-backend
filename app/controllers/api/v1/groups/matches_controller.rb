module Api
  module V1
    module Groups
      class MatchesController < ApiController
        include Api::V1::GroupsConcern

        before_action :load_group, only: [:create]
        before_action :check_admin_auth, only: [:create]

        def create
          @match = Match.create(create_params.merge(creator: @group.affiliation(current_user), group: @group, status: Match::INITIAL_STATUS))
          bad_request(message: "Bad params: #{@match.errors.full_messages.join('. ')}") unless @match.valid?
        end

        private

        def create_params
          params.require(:v1_groups_matches).permit(:name, :date, :duration, :min_players, :max_players, :location, :latitude, :longitude)
        end
      end
    end
  end
end
