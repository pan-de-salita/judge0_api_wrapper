module Api
  class StatusesController < ApplicationController
    def index
    statuses = Judge0::Client.statuses
      render json: statuses
    end
  end
end
