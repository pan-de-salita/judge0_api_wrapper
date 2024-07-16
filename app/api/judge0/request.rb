# frozen_string_literal: true

module Judge0
  BASE_URL = 'https://judge0-ce.p.rapidapi.com'
  AUTHENTICATION_TOKEN = ENV['X_RAPIDAPI_KEY']
  HEADERS = {
    'Content-Type' => 'application/json',
    'x-rapidapi-key': AUTHENTICATION_TOKEN,
    'x-rapidapi-host': 'judge0-ce.p.rapidapi.com'
  }.freeze

  CONNECTION = Faraday.new(url: BASE_URL, headers: HEADERS) do |faraday|
    faraday.response :json
    faraday.response :raise_error
  end

  class Request
    def self.call(http_method:, endpoint:, body: nil)
      result = if body.nil?
                 CONNECTION.send(http_method, endpoint)
               else
                 CONNECTION.send(http_method, endpoint, body)
               end
      process(result)
    end

    def self.process(result)
      {
        status: result.status,
        reason_phrase: result.reason_phrase,
        submissions_ramaining: result.headers['x-ratelimit-submissions-remaining'],
        data: result.body
      }
    rescue Faraday::Error => e
      format(e)
    end

    def self.format(error)
      {
        status: error.response_status,
        message: Errors.translate(error.response_status),
        data: error.response_body
      }
    end
  end
end
