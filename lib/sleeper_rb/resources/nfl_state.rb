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

      ##
      # :attr_reader: week

      ##
      # :attr_reader: season_type

      ##
      # :attr_reader: season

      ##
      # :attr_reader: league_season

      ##
      # :attr_reader: season_start_date

      ##
      # :attr_reader: previous_season

      ##
      # :attr_reader: leg

      ##
      # :attr_reader: league_create_season

      ##
      # :attr_reader: display_week

      cached_attr :week, :season_type, :season, :league_season, :season_start_date, :previous_season,
                  :leg, :league_create_season, :display_week

      private

      def retrieve_values!
        execute_request(URI("#{BASE_URL}/state/nfl"))
      end
    end
  end
end
