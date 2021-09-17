# frozen_string_literal: true

require_relative "utilities/array_proxy"
require_relative "utilities/cache"
require_relative "utilities/request"
require_relative "utilities/roster_position"
require_relative "resources/avatar"
require_relative "resources/draft"
require_relative "resources/draft_array"
require_relative "resources/league"
require_relative "resources/league_array"
require_relative "resources/nfl_state"
require_relative "resources/player"
require_relative "resources/player_array"
require_relative "resources/traded_pick"
require_relative "resources/traded_pick_array"
require_relative "resources/user"
require_relative "resources/user_array"

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
    # @return {SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]
    def user(username: nil, user_id: nil)
      Resources::User.new(username: username, user_id: user_id)
    end

    ##
    # Returns an avatar found by the alphanumeric ID.
    #
    # @param avatar_id [String] The ID for the avatar
    #
    # @return {SleeperRb::Resources::Avatar}[rdoc-ref:SleeperRb::Resources::Avatar]
    def avatar(avatar_id)
      Resources::Avatar.new(avatar_id: avatar_id)
    end

    ##
    # Returns a League found by the alphanumeric ID.
    #
    # @param league_id [String] The ID for the League
    #
    # @return {SleeperRb::Resources::League}[rdoc-ref:SleeperRb::Resources::League]
    def league(league_id)
      Resources::League.new(league_id: league_id)
    end

    ##
    # Returns all NFL players.
    #
    # @return [{SleeperRb::Resources::PlayerArray}[rdoc-ref:SleeperRb::Resources::PlayerArray]]
    def players
      Resources::PlayerArray.new(Resources::Player.all)
    end

    ##
    # Returns a specific Draft.
    #
    # @return [{SleeperRb::Resources::Draft}[rdoc-ref:SleeperRb::Resources::Draft]]
    def draft(draft_id)
      Resources::Draft.new(draft_id: draft_id)
    end
  end
end
