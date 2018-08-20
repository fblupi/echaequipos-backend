module Api
  module V1
    class PositionsController < ApiController
      def index
        @positions = Position.all
      end
    end
  end
end