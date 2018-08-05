module Api
  module V1
    module Users
      class AffiliationsController < ApiController
        def index
          @affiliations = { current: current_user.current_affiliations, invitations: current_user.invitation_affiliations }
        end
      end
    end
  end
end
