# frozen_string_literal: true

# The Judge0::Client class serves as a high-level interface for interacting with the Judge0 API.
# It abstracts the underlying HTTP request mechanism, providing a straightforward way to access
# various endpoints related to problems, languages, and other aspects of the Judge0 platform.
module Judge0
  # == Overview
  #
  # This class offers methods corresponding to common operations you'd perform with the Judge0 API,
  # such as fetching problem statuses, retrieving information about programming languages, and
  # accessing individual language details.
  #
  # == Methods
  #
  # - #status
  #   Retrieves the current status of problems submitted to the Judge0 system.
  #
  # - #languages
  #   Fetches a list of currently active programming languages supported by Judge0.
  #
  # - #all_languages
  #   Returns a list of both active and archived programming languages.
  #
  # - #language(id:)
  #   Obtains detailed information about a specific programming language by its ID.
  #
  # == Examples
  #
  # Fetch the current status of problems:
  #   Judge0::Client.statuses
  #
  # Retrieve a list of active programming languages:
  #   Judge0::Client.languages
  #
  # Get information about all programming languages:
  #   Judge0::Client.all_languages
  #
  # Get details about a specific programming language by ID:
  #   Judge0::Client.language(id: 72) # -> Returns information on Ruby
  class Client
    def self.statuses
      Request.call(http_method: 'get', endpoint: '/statuses')
    end

    def self.languages
      Request.call(http_method: 'get', endpoint: '/languages')
    end

    def self.all_languages
      Request.call(http_method: 'get', endpoint: '/languages/all')
    end

    def self.language(id:)
      Request.call(http_method: 'get', endpoint: "/languages/#{id}")
    end
  end
end
