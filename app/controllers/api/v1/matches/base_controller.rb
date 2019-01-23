module Api
  module V1
    module Matches
      class BaseController < ApiController
        private

        def load_match
          @match = Match.find_by_id(params[:id])
          bad_request unless @match
        end

        def check_auth_admin
          unauthorized(message: 'You are not an admin of this match.') unless @match&.group&.admin?(current_user)
        end
      end
    end
  end
end
