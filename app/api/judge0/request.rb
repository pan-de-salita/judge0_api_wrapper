# frozen_string_literal: true

# The Judge0::Request class provides a simplified interface for making HTTP requests to the Judge0 API.
#
# It encapsulates the setup for the Faraday HTTP client, including the base URL and authentication token,
# allowing users to easily send requests to various endpoints of the Judge0 API.
#
# == Examples
#
#   # Send a GET request to fetch problem statuses
#   Judge0::Request.call(http_method: :get, endpoint: '/statuses')
#
# == Available Endpoints
#
# This class supports all endpoints available in the Judge0 API. For a full list of supported endpoints,
# refer to the official Judge0 API documentation.
#
# == Note
#
# The `call` method dynamically determines the HTTP method based on the provided symbol. Ensure that the
# symbol matches one of the HTTP methods supported by the Judge0 API (e.g., :get, :post).
module Judge0
  BASE_URL = 'https://judge0-ce.p.rapidapi.com'
  AUTHENTICATION_TOKEN = ENV['X_RAPIDAPI_KEY']
  CONNECTION = Faraday.new(
    url: BASE_URL,
    headers: { 'x-rapidapi-key': AUTHENTICATION_TOKEN, 'x-rapidapi-host': 'judge0-ce.p.rapidapi.com' }
  )

  # Sends an HTTP request to the specified endpoint of the Judge0 API.
  #
  # @param [String] http_method: The HTTP method to use for the request (:get, :post, etc.)
  # @param [String] endpoint: The endpoint path relative to the base URL
  # @return [Hash]: The parsed response body as a hash
  class Request
    def self.call(http_method:, endpoint:)
      CONNECTION.send(http_method.to_sym, endpoint)
    end
  end
end
