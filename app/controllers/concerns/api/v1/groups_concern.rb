module Api
  module V1
    module GroupsConcern
      include ActiveSupport::Concern

      def load_group
        group_id = params[:id]
        return bad_request unless group_id
        @group = Group.find_by_id(group_id)
      end

      def check_auth
        unauthorized(message: 'You are not authorized to this group.') unless @group.exist_user?(current_user)
      end
    end
  end
end
