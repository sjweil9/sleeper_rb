# frozen_string_literal: true

require "singleton"

module SleeperRb
  module Resources
    class NflState
      include Singleton
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      lazy_attr_reader :week, :season_type, :season, :league_season

      private

      def retrieve_values!
        execute_request(URI("#{BASE_URL}/state/nfl"))
      end
    end
  end
end