# frozen_string_literal: true

module Judge0
  # Judge0 API Client Library
  #
  # A Ruby module simplifying interactions with the Judge0 API, supporting operations such
  # as fetching system statuses, listing supported languages, submitting code for evaluation,
  # and querying submission details.
  #
  # Key Features:
  # - Status Management: Operational status checks.
  # - Language Support: Listing available programming languages.
  # - Submission Handling: Code submission and retrieval of submission details.
  # - Error Handling: Checks for invalid inputs and missing parameters.
  #
  # Getting Started:
  # Subscribe to Judge0's FREE Basic Plan on RapidAPI or host the API on your local machine.
  # Detailed instructions can be found on https://ce.judge0.com/.
  class Client
    # Fetches the current statuses of the Judge0 service.
    def self.statuses
      Request.call(http_method: :get, endpoint: '/statuses')
    end

    # Retrieves a list of supported languages.
    def self.languages
      Request.call(http_method: :get, endpoint: '/languages')
    end

    # Returns all available languages, including those not currently supported.
    def self.all_languages
      Request.call(http_method: :get, endpoint: '/languages/all')
    end

    # Fetches details about a specific language using its ID.
    # Requires an integer `language_id`.
    def self.language(language_id:)
      raise ArgumentError, 'Invalid language ID' unless language_id.is_a?(Integer)

      Request.call(http_method: :get, endpoint: "/languages/#{language_id}")
    end

    # Submits source code for judging.
    # Requires:
    #   - A string `source_code`
    #   - An integer `language_id`
    #   - Optional string `stdin` for standard input
    def self.write_submission(source_code:, language_id:, stdin: nil)
      raise ArgumentError, 'Missing required source code' if source_code.blank?
      raise ArgumentError, 'Invalid language ID' unless language_id.is_a?(Integer)

      Request.call(
        http_method: :post,
        endpoint: '/submissions/?base64_encoded=false&wait=false',
        body: { 'source_code': source_code, 'language_id': language_id, 'stdin': stdin }.to_json
      )
    end

    # Reads submission details using a submission token.
    # Requires a valid `token`. Optionally specifies which fields to return.
    def self.read_submission(token:, fields: %w[source_code stdout stderr status_id language_id token])
      raise ArgumentError, 'Missing required submission token' if token.nil?

      Request.call(http_method: :get,
                   endpoint: "/submissions/#{token}?base64_encoded=false&fields=#{fields.join(',')}")
    end
  end
end
