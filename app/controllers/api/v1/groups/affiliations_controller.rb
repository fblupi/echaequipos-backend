module Api
  module V1
    module Groups
      class AffiliationsController < BaseController
        before_action :load_group, only: [:show]
        before_action :check_auth, only: [:show]

        def show
          @affiliations = @group.affiliations
        end
      end
    end
  end
end
