require "singleton"

module SleeperRb
  class NflState
    include Singleton
    include SleeperRb::Request

    def initialize
      retrieve_values!
    end

    def refresh
      retrieve_values!
      self
    end

    attr_reader :week, :season_type, :season, :league_season

    private

    def retrieve_values!
      object = execute_request(URI("#{BASE_URL}/state/nfl"))
      @week = object["week"]
      @season_type = object["season_type"]
      @season = object["season"]
      @league_season = object["league_season"]
    end
  end
end