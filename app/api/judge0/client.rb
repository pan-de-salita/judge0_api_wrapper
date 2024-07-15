# frozen_string_literal: true

module Judge0
  class Client
    def self.statuses
      Request.call(http_method: :get, endpoint: '/statuses')
    end

    def self.languages
      Request.call(http_method: :get, endpoint: '/languages')
    end

    def self.all_languages
      Request.call(http_method: :get, endpoint: '/languages/all')
    end

    def self.language(language_id:)
      Request.call(http_method: :get, endpoint: "/languages/#{language_id}")
    end

    def self.write_submission(source_code:, language_id:, stdin: nil)
      raise ArgumentError, 'Missing required source code' if source_code.blank?
      raise ArgumentError, 'Invalid language ID' unless language_id.is_a?(Integer)

      Request.call(http_method: :post, endpoint: '/submissions/?base64_encoded=false&wait=false',
                   body: { 'source_code': source_code, 'language_id': language_id, 'stdin': stdin })
    end

    def self.read_submission(token:, fields: %w[stdout stderr status_id language_id])
      Request.call(http_method: :get, endpoint: "/submissions/#{token}?base64_encoded=false&fields=#{fields.join(',')}")
    end

    protected

    def format_fields(field_arr)
      field_arr.split(/\s+/).join(',')
    end
  end
end