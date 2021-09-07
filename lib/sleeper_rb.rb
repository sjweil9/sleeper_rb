# frozen_string_literal: true

require_relative "sleeper_rb/version"
require_relative "sleeper_rb/client"

module SleeperRb
  class BadRequest < StandardError; end

  class NotFound < StandardError; end

  class ServerError < StandardError; end

  class RateLimitExceeded < StandardError; end
end
