# frozen_string_literal: true

module Judge0
  BASE_URL = 'https://judge0-ce.p.rapidapi.com'
  HEADERS = {
    'Content-Type': 'application/json',
    'x-rapidapi-key': ENV['X_RAPIDAPI_KEY'],
    'x-rapidapi-host': 'judge0-ce.p.rapidapi.com'
  }.freeze

  CONNECTION = Faraday.new(url: BASE_URL, headers: HEADERS) do |faraday|
    faraday.request :json
    faraday.response :json
    faraday.response :raise_error
    faraday.response :logger
  end

  class Request
    def self.call(http_method:, endpoint:, body: nil)
      result = CONNECTION.send(http_method, endpoint) do |req|
        req.body = body unless body.nil?
      end

      { status: result.status, reason_phrase: result.reason_phrase,
        submissions_remaining: result.headers['x-ratelimit-submissions-remaining'].to_i, data: result.body }
    rescue Faraday::Error => e
      data = e.response_body.blank? ? nil : JSON.parse(e.response_body)
      { status: e.response_status, message: Errors.translate(e.response_status), data: }
    end
  end
end
