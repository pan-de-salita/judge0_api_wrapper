# frozen_string_literal: true

module Judge0
  BASE_URL = 'https://judge0-ce.p.rapidapi.com'
  AUTHENTICATION_TOKEN = ENV['X_RAPIDAPI_KEY']
  CONNECTION = Faraday.new(
    url: BASE_URL,
    headers: { 'x-rapidapi-key': AUTHENTICATION_TOKEN, 'x-rapidapi-host': 'judge0-ce.p.rapidapi.com' }
  ) do |faraday|
    faraday.response :raise_error
  end

  class Request
    def self.call(http_method:, endpoint:, body: nil)
      result = body.nil? ? CONNECTION.send(http_method, endpoint) : CONNECTION.send(http_method, endpoint, body)

      format(result)
    end

    def format(result)
      {
        status: result.status,
        reason_phrase: result.reason_phrase,
        submissions_ramaining: result.headers['x-ratelimit-submissions-remaining'],
        data: JSON.parse(result.body)
      }
    rescue Faraday::Error => e
      { status: e.response_status, message: Errors.translate(e.response_status), data: e.response_body }
    end
  end
end
