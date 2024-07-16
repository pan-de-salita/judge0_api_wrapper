# frozen_string_literal: true

module Api
  module V1
    class LanguagesController < ActionController::API
      before_action :obtain_languages

      def index
        render json: @languages
      end

      def index_active
        active_languages = @languages.merge({ data: @languages[:data].filter { |lang| lang['is_archived'] == false } })
        render json: active_languages
      end

      def index_archived
        archived_languages = @languages.merge({ data: @languages[:data].filter { |lang| lang['is_archived'] == true } })
        render json: archived_languages
      end

      private

      def obtain_languages
        @languages = Judge0::Client.all_languages
      end
    end
  end
end
