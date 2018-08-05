module Api
  module V1
    module Affiliations
      class BaseController < ApiController
        private

        def load_affiliation
          affiliation_id = params[:id]
          return bad_request unless affiliation_id
          @affiliation = Affiliation.find_by_id(affiliation_id)
        end

        def check_auth_current_user
          unauthorized(message: 'You are not authorized to change this affiliation.') unless @affiliation.user == current_user
        end

        def check_auth_admin
          unauthorized(message: 'Your are not an admin of this group.') unless @affiliation.group.is_admin?(current_user)
        end
      end
    end
  end
end
