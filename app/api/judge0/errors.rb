# frozen_string_literal: true

module Judge0
  class Errors
    def self.translate(code)
      case code
      when 400
        'Bad request error'
      when 401
        'Unauthorized error'
      when 403
        'Forbidden error'
      when 404
        'Resource not found'
      when 407
        'Proxy auth error'
      when 408
        'Reqeuest timeout error'
      when 409
        'Conflict error'
      when 422
        'Unprocessable entity error'
      when 429
        'Too many requests error'
      else
        'Client/server error'
      end
    end
  end
end
