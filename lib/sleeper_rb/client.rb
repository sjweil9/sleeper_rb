require "net/http"
require "json"
require_relative "./request"
require_relative "./nfl_state"

module SleeperRb
  class Client
    def nfl_state
      NflState.instance
    end
  end
end