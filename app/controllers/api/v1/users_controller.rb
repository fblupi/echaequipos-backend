module Api
  module V1
    class UsersController < ApiController
      def update_device_token
        @user = current_user if current_user.update(token_params)
      end

      private

      def token_params
        params.require(:v1_users_update_device_token).permit(:device_token)
      end
    end
  end
end
