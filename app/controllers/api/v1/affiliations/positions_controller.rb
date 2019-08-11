module Api
  module V1
    module Affiliations
      class PositionsController < ApiController
        include Api::V1::AffiliationsConcern

        before_action :load_affiliation, only: [:show, :update]
        before_action :check_auth_current_user, only: [:update]

        def show
          @positions = @affiliation.positions
        end

        def update
          position_ids = params.require(:v1_affiliations_positions)[:position_ids]
          @affiliation.positions = Position.find(position_ids)
        end
      end
    end
  end
end
