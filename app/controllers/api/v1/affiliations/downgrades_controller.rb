module Api
  module V1
    module Affiliations
      class DowngradesController < ApiController
        include Api::V1::AffiliationsConcern

        before_action :load_affiliation_by_id, only: [:update]
        before_action :check_affiliation_auth_admin, only: [:update]

        def update
          return bad_request(message: 'The user has not accepted the invitation yet.') if @affiliation.invitation?
          return bad_request(message: 'The user is already a normal user in this group.') if @affiliation.normal?
          @affiliation.downgrade_normal
        end
      end
    end
  end
end
