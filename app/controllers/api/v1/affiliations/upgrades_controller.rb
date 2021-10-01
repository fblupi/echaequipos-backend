module Api
  module V1
    module Affiliations
      class UpgradesController < ApiController
        include Api::V1::AffiliationsConcern

        before_action :load_affiliation_by_affiliation_id, only: [:update]
        before_action :check_affiliation_auth_admin, only: [:update]

        def update
          return bad_request(message: 'The user has not accepted the invitation yet.') if @affiliation.invitation?
          return bad_request(message: 'The user is already an admin in this group.') if @affiliation.admin?

          @affiliation.upgrade_admin
        end
      end
    end
  end
end
