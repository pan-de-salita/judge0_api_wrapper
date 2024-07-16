# frozen_string_literal: true

module Api
  module V1
    class StatusesController < ApplicationController
      before_action :fetch_statuses

      def index
        render json: @statuses
      end

      private

      def fetch_statuses
        @statuses = Judge0::Client.statuses
      end
    end
  end
end
