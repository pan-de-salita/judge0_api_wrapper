# frozen_string_literal: true

module Judge0
  BASE_URL = 'https://judge0-ce.p.rapidapi.com'
  AUTHENTICATION_TOKEN = ENV['X_RAPIDAPI_KEY']
  CONNECTION = Faraday.new(
    url: BASE_URL,
    headers: { 'x-rapidapi-key': AUTHENTICATION_TOKEN, 'x-rapidapi-host': 'judge0-ce.p.rapidapi.com' }
  )

  class Request
    def self.call(http_method:, endpoint:, body: nil)
      result = body.nil? ? CONNECTION.send(http_method, endpoint) : CONNECTION.send(http_method, endpoint, body)

      { status: result.status, reason_phrase: result.reason_phrase, data: JSON.parse(result.body) }
    end
  end
end
