module Api
  module V1
    module Matches
      class FinishesController < ApiController
        include Api::V1::MatchesConcern

        before_action :load_match, only: [:update]
        before_action :check_auth_admin, only: [:update]

        def update
          @match.finish
        end
      end
    end
  end
end
