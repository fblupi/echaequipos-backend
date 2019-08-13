module Api
  module V1
    module Players
      class RejectionsController < ApiController
        include Api::V1::PlayersConcern

        before_action :load_player_by_player_id, only: [:update]
        before_action :check_player_auth, only: [:update]

        def update
          @player.quit
        end
      end
    end
  end
end
