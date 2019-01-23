module Api
  module V1
    module GroupsConcern
      include ActiveSupport::Concern

      def load_group
        @group = Group.find_by_id(params[:group_id])
        bad_request unless @group
      end

      def check_auth
        unauthorized(message: 'You are not authorized to this groups.') unless @group.exist_user?(current_user)
      end

      def check_admin_auth
        unauthorized(message: 'You have no admin authorization in this groups.') unless @group.admin?(current_user)
      end
    end
  end
end
