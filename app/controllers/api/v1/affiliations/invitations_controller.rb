module Api
  module V1
    module Affiliations
      class InvitationsController < BaseController
        before_action :load_affiliation, only: [:update]
        before_action :check_auth_current_user, only: [:update]

        def create
          email = params.require(:v1_affiliations_invitations)[:email]
          group_id = params.require(:v1_affiliations_invitations)[:group_id]
          return bad_request if !email || !group_id

          group = current_user.groups.find_by_id(group_id)
          user = User.find_by_email(email)
          return unauthorized(message: 'You are not authorized to invite people to this group.') if !group || !current_user.affiliations.find_by_group_id(group_id)&.is_admin?
          return bad_request(message: 'The user does not exists or it is currently in the group.') if group.exist_user?(user)
          @affiliation = group.invite_user(user)
        end

        def update
          return bad_request(message: 'You have already accepted the invitation.') unless @affiliation.is_invitation?
          @affiliation.accept_invitation
        end
      end
    end
  end
end