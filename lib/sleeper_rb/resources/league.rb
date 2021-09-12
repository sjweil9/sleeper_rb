# frozen_string_literal: true

require_relative "league/scoring_settings"
require_relative "league/settings"
require_relative "league/roster"

module SleeperRb
  module Resources
    ##
    # This class represents a Fantasy Football League and is the access point for associated resources.
    class League
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :total_rosters, :status, :sport, :season_type, :season, :previous_league_id, :name, :league_id,
                  :draft_id, avatar: ->(id) { Resources::Avatar.new(avatar_id: id) },
                             scoring_settings: ->(settings) { ScoringSettings.new(settings) },
                             roster_positions: lambda { |array|
                                                 array.map do |pos|
                                                   SleeperRb::Utilities::RosterPosition.new(pos)
                                                 end
                                               },
                             settings: ->(settings) { Settings.new(settings) }

      ##
      # @return [Array<{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]>]
      cached_association(:rosters) do
        retrieve_rosters!
      end

      def initialize(opts = {})
        raise ArgumentError unless opts[:league_id]

        super
      end

      SleeperRb::Utilities::RosterPosition::VALID_ROSTER_POSITIONS.each do |pos|
        define_method(pos) { roster_positions.select(&:"#{pos}?").size }
      end

      private

      def retrieve_values!
        url = "#{BASE_URL}/league/#{league_id}"
        execute_request(url)
      end

      def retrieve_rosters!
        url = "#{BASE_URL}/league/#{league_id}/rosters"
        response = execute_request(url)
        response.map { |hash| Roster.new(hash) }
      end
    end
  end
end
