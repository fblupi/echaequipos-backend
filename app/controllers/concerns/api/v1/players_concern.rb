module Api
  module V1
    module PlayersConcern
      include ActiveSupport::Concern

      def load_player_by_player_id
        load_player(:player_id)
      end

      def check_valid_player
        bad_request(message: "Bad params: #{@player.errors.full_messages.join('. ')}") unless @player.valid?
      end

      private

      def load_player(param)
        @player = Player.find(params[param])
      end
    end
  end
end
