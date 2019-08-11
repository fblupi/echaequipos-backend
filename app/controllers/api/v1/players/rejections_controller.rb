module Api
  module V1
    module Players
      class RejectionsController < ApiController
        include Api::V1::PlayersConcern

        before_action :load_player_by_player_id, only: [:update]

        def update
          @player.quit
        rescue ActiveRecord::RecordInvalid => error
          error_request(message: error.message)
        end
      end
    end
  end
end
