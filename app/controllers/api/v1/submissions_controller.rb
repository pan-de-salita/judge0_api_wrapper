# frozen_string_literal: true

module Api
  module V1
    class SubmissionsController < ApplicationController
      # attr_accessor :submission_token

      def create
        submission = Judge0::Client.write_submission(
          source_code: write_submission_params[:source_code],
          language_id: write_submission_params[:language_id],
          stdin: write_submission_params[:stdin]
        )

        # @submission_token = create_submission[:data]['token'] if create_submission[:status].between(200, 299)
        render json: submission
      end

      def show
        result = Judge0::Client.read_submission(token: read_submission_params[:token])
        render json: result
      end

      private

      def write_submission_params
        params.permit %i[source_code language_id stdin]
      end

      def read_submission_params
        params.permit :token
      end
    end
  end
end
