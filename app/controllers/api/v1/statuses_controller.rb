# frozen_string_literal: true

module Api
  module V1
    class StatusesController < ActionController::API
      def index
        statuses = Judge0::Client.statuses
        render json: statuses
      end
    end
  end
end
