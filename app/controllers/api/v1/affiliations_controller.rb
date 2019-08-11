module Api
  module V1
    class AffiliationsController < ApiController
      include Api::V1::AffiliationsConcern

      before_action :load_affiliation_by_id, only: [:update]
      before_action :check_affiliation_auth, only: [:update]

      def index
        @affiliations = { current: current_user.current_affiliations, invitations: current_user.invitation_affiliations }
      end

      def create
        begin
          email = params.require(:v1_affiliations)[:email]
          group_id = params.require(:v1_affiliations)[:group_id]
        rescue ActionController::ParameterMissing
          bad_request
        end
        return bad_request unless email

        group = current_user.groups.find(group_id)
        user = User.find_by(email: email)
        return unauthorized(message: 'You are not authorized to invite people to this group.') if !group || !current_user.affiliations.find_by(group_id: group.id)&.admin?
        return bad_request(message: 'The user does not exists or it is currently in the group.') if group.exist_user?(user)
        @affiliation = group.invite_user(user)
      end

      def update
        return bad_request(message: 'You have already accepted the invitation.') unless @affiliation.invitation?
        @affiliation.accept_invitation
      end
    end
  end
end
