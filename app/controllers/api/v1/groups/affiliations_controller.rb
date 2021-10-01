module Api
  module V1
    module Groups
      class AffiliationsController < ApiController
        include Api::V1::GroupsConcern

        before_action :load_group_by_group_id, only: %i[index create]
        before_action :check_group_auth, only: [:index]

        def index
          @affiliations = @group.affiliations
        end

        def create
          user = User.find_by(email: params.require(:v1_group_affiliations)[:email])
          unless current_user.group_admin?(@group)
            return unauthorized(message: 'You are not authorized to invite people to this group.')
          end
          if !user || @group.exist_user?(user)
            return bad_request(message: 'The user does not exists or it is currently in the group.')
          end

          @affiliation = @group.invite_user(user)
        end
      end
    end
  end
end
