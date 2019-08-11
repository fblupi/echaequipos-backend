module Api
  module V1
    module GroupsConcern
      include ActiveSupport::Concern

      def load_group_by_group_id
        load_group(:group_id)
      end

      def check_group_auth
        unauthorized(message: 'You are not authorized to this groups.') unless @group.exist_user?(current_user)
      end

      def check_group_auth_admin
        unauthorized(message: 'You have no admin authorization in this groups.') unless @group.admin?(current_user)
      end

      def group_params
        params.require(:v1_groups).permit(:name, :location)
      end

      private

      def load_group(param)
        @group = Group.find(params[param])
      end
    end
  end
end
