module Api
  module V1
    module AffiliationsConcern
      include ActiveSupport::Concern

      def load_affiliation_by_id
        load_affiliation(:id)
      end

      def load_affiliation_by_affiliation_id
        load_affiliation(:affiliation_id)
      end

      def check_affiliation_auth
        unless @affiliation&.user == current_user
          unauthorized(message: 'You are not authorized to change this affiliation.')
        end
      end

      def check_affiliation_auth_admin
        unauthorized(message: 'You are not an admin of this group.') unless @affiliation&.user_admin?(current_user)
      end

      private

      def load_affiliation(param)
        @affiliation = Affiliation.find(params[param])
      end
    end
  end
end
