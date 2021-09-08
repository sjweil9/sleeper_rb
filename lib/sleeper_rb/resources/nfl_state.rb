# frozen_string_literal: true

require "singleton"

module SleeperRb
  module Resources
    ##
    # The NflState resource represents the current state of the NFL (week number, year, etc) as defined by Sleeper.
    class NflState
      include Singleton
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :week, :season_type, :season, :league_season, :season_start_date, :previous_season,
                  :leg, :league_create_season, :display_week

      private

      def retrieve_values!
        execute_request(URI("#{BASE_URL}/state/nfl"))
      end
    end
  end
end
