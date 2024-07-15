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
      Request.call(http_method: :post, endpoint: '/submissions/?base64_encoded=false&wait=false',
                   body: { 'source_code': source_code, 'language_id': language_id, 'stdin': stdin })
    end

    def self.read_submission(token:)
      Request.call(http_method: :get,
                   endpoint: "/submissions/#{token}?base64_encoded=false&fields=stdout,stderr,status_id,language_id")
    end
  end
end
