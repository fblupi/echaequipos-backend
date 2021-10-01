module Api
  module V1
    module Groups
      class MatchesController < ApiController
        include Api::V1::GroupsConcern
        include Api::V1::MatchesConcern

        before_action :load_group_by_group_id, only: [:create]
        before_action :check_group_auth_admin, only: [:create]

        def create
          @match = Match.create(group_match_params.merge(creator: @group.affiliation(current_user), group: @group,
                                                         status: Match::INITIAL_STATUS))
          check_valid_match
        end
      end
    end
  end
end
