# frozen_string_literal: true

require_relative "utilities/request"
require_relative "utilities/cache"
require_relative "resources/nfl_state"
require_relative "resources/user"

module SleeperRb
  ##
  # A SleeperRb::Client instance is the interface for formulating all requests for Sleeper data.
  class Client
    ##
    # Returns the current NflState.
    #
    # @return {SleeperRb::Resources::NflState}[rdoc-ref:SleeperRb::Resources::NflState] The NflState instance
    def nfl_state
      Resources::NflState.instance
    end

    ##
    # Returns a user found by either username or user_id. Usernames are subject to change and are thus unstable.
    #
    # @param username [String] The current username
    #
    # @param user_id [String] The numerical user_id
    #
    # @return {SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User] The User instance
    def user(username: nil, user_id: nil)
      Resources::User.new(username: username, user_id: user_id)
    end
  end
end
