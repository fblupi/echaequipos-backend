module Api
  module V1
    module Affiliations
      class PositionsController < ApiController
        include Api::V1::AffiliationsConcern

        before_action :load_affiliation_by_affiliation_id, only: [:show, :update]
        before_action :check_affiliation_auth, only: [:update]

        def show
          @positions = @affiliation.positions
        end

        def update
          @affiliation.positions = Position.find(params.require(:v1_affiliation_positions)[:position_ids])
        end
      end
    end
  end
end
