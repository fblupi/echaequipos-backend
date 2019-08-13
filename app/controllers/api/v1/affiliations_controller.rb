module Api
  module V1
    class AffiliationsController < ApiController
      include Api::V1::AffiliationsConcern

      before_action :load_affiliation_by_id, only: [:update]
      before_action :check_affiliation_auth, only: [:update]

      def index
        @affiliations = { current: current_user.current_affiliations, invitations: current_user.invitation_affiliations }
      end

      def update
        return bad_request(message: 'You have already accepted the invitation.') unless @affiliation.invitation?
        @affiliation.accept_invitation
      end
    end
  end
end
