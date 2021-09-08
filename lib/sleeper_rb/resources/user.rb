# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # The User resource represents a single user in Sleeper. This also serves as the access points for associated data.
    class User
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :user_id, :username, :display_name, :avatar

      ##
      # Initializes a user, with either username or user_id.
      # @param username [String] The current username
      # @param user_id [String] The numerical user_id
      def initialize(user_id: nil, username: nil)
        raise ArgumentError, "must provide either user_id or username" unless user_id || username

        @user_id = user_id if user_id
        @username = username if username
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/user/#{@user_id || @username}")
        response = execute_request(uri)
        response[:avatar] = Resources::Avatar.new(response.delete(:avatar))
        response
      end
    end
  end
end
