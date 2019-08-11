module Api
  module V1
    class GroupsController < ApiController
      def create
        return bad_request(message: 'Group name is required') unless group_params[:name]
        @group = current_user.create_group(name: group_params[:name], location: group_params[:location])
        return error_request(message: 'There was an error while creating the group') unless @group
        self.status = :created
      end

      private

      def group_params
        params.require(:v1_group).permit(:name, :location)
      end
    end
  end
end
