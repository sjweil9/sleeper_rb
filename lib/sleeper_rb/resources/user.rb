# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # The User resource represents a single user in Sleeper. This also serves as the access points for associated data.
    class User
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :user_id, :username, :display_name,
                  avatar: ->(id) { id ? Resources::Avatar.new(avatar_id: id) : nil }

      ##
      # Initializes a user, with either username or user_id.
      #
      # @param username [String] The current username
      #
      # @param user_id [String] The numerical user_id
      def initialize(opts)
        raise ArgumentError, "must provide either user_id or username" unless opts[:user_id] || opts[:username]

        super
      end

      ##
      # Retrieves leagues for the user for the given season.
      #
      # @param season [String] The year in which the leagues were played
      #
      # @return [Array<{SleeperRb::Resources::League}[rdoc-ref:SleeperRb::Resources::League]>]
      association(:leagues) do |season|
        retrieve_leagues!(season)
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/user/#{@user_id || @username}")
        execute_request(uri)
      end

      def retrieve_leagues!(season)
        uri = URI("#{BASE_URL}/user/#{user_id}/leagues/nfl/#{season}")
        response = execute_request(uri)
        response.map { |hash| Resources::League.new(hash) }
      end
    end
  end
end
