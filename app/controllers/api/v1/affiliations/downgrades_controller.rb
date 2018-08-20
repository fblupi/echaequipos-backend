module Api
  module V1
    module Affiliations
      class DowngradesController < BaseController
        before_action :load_affiliation, only: [:update]
        before_action :check_auth_admin, only: [:update]

        def update
          return bad_request(message: 'The user is already a normal user in this group.') if @affiliation.normal?
          @affiliation.downgrade_normal
        end
      end
    end
  end
end
