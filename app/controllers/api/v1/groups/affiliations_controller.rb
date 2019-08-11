module Api
  module V1
    module Groups
      class AffiliationsController < ApiController
        include Api::V1::GroupsConcern

        before_action :load_group_by_group_id, only: [:index]
        before_action :check_group_auth, only: [:index]

        def index
          @affiliations = @group.affiliations
        end
      end
    end
  end
end
