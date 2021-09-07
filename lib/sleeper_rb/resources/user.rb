# frozen_string_literal: true

module SleeperRb
  module Resources
    class User
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      lazy_attr_reader :user_id, :username, :display_name, :avatar

      def initialize(user_id: nil, username: nil)
        raise ArgumentError, "must provide either user_id or username" unless user_id || username
        @user_id = user_id if user_id
        @username = username if username
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/user/#{@user_id || @username}")
        execute_request(uri)
      end
    end
  end
end