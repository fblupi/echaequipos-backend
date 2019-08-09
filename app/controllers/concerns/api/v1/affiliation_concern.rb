module Api
  module V1
    module AffiliationConcern
      include ActiveSupport::Concern

      def load_affiliation
        affiliation_id = params[:id]
        return bad_request unless affiliation_id
        @affiliation = Affiliation.find_by_id(affiliation_id)
      end

      def check_auth_current_user
        unauthorized(message: 'You are not authorized to change this affiliation.') unless @affiliation&.user == current_user
      end

      def check_auth_admin
        unauthorized(message: 'You are not an admin of this group.') unless @affiliation&.group&.admin?(current_user)
      end
    end
  end
end
