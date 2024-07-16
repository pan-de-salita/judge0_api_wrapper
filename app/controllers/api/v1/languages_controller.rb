# frozen_string_literal: true

module Api
  module V1
    class LanguagesController < ActionController::API
      before_action :fetch_languages

      def index
        filter_language_by_active_status(languages_params[:active].to_s.downcase) if languages_params[:active]
        render(json: @languages)
      end

      private

      def fetch_languages
        @languages = Judge0::Client.all_languages
      end

      def languages_params
        params.permit :active
      end

      def filter_language_by_active_status(active_status)
        case active_status
        when 'true'
          active_languages
        when 'false'
          archived_languages
        else
          language_category_error
        end
      end

      def active_languages
        @languages[:data] = @languages[:data].reject { |lang| lang['is_archived'] }
      end

      def archived_languages
        @languages[:data] = @languages[:data].select { |lang| lang['is_archived'] }
      end

      def language_category_error
        @languages = { status: 400, reason_phrase: 'No such language category' }
      end
    end
  end
end
