# frozen_string_literal: true

require "net/http"
require "json"
require "tempfile"

module SleeperRb
  module Utilities
    ##
    # This module encapsulates the logic for handling the response when querying from the Sleeper API.
    module Request
      BASE_URL = "https://api.sleeper.app/v1"

      private

      def execute_request(url)
        response = Net::HTTP.get_response(URI(url))

        case response.code.to_i
        when 200 then JSON.parse(response.body, symbolize_names: true)
        when 400 then raise BadRequest
        when 404 then raise NotFound
        when 429 then raise RateLimitExceeded
        else raise ServerError
        end
      end

      def download_file(url, filename)
        uri = URI(url)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          resp = http.get(uri.path)
          file = Tempfile.new(filename)
          file.binmode
          file.write(resp.body)
          file.flush
          file
        end
      end
    end
  end
end
