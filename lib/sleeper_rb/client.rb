# frozen_string_literal: true

require_relative "utilities/request"
require_relative "utilities/cache"
require_relative "nfl_state"
require_relative "user"

module SleeperRb
  class Client
    def nfl_state
      NflState.instance
    end

    def user(username: nil, user_id: nil)
      User.new(username: username, user_id: user_id)
    end
  end
end