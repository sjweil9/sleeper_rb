# frozen_string_literal: true

require "net/http"
require "json"

module SleeperRb
  module Utilities
    module Request
      BASE_URL = "https://api.sleeper.app/v1"

      private

      def execute_request(url)
        response = Net::HTTP.get_response(URI(url))

        case response.code.to_i
        when 200 then JSON.parse(response.body)
        when 400 then raise BadRequest
        when 404 then raise NotFound
        when 429 then raise RateLimitExceeded
        else raise ServerError
        end
      end
    end
  end
end
