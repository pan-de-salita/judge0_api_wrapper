# frozen_string_literal: true

module Api
  module V1
    class SubmissionsController < ApplicationController
      def create
        submission = Judge0::Client.write_submission(
          source_code: create_submission_params[:source_code],
          language_id: create_submission_params[:language_id],
          stdin: create_submission_params[:stdin]
        )
        render json: submission
      end

      def show
        result = Judge0::Client.read_submission(token: read_submission_params[:token])
        render json: result
      end

      private

      def create_submission_params
        params.require(:submission).permit :source_code, :language_id, :stdir
      end

      def read_submission_params
        params.require(:submission).permit :token
      end
    end
  end
end
