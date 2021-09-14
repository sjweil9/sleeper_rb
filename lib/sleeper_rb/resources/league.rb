# frozen_string_literal: true

require_relative "league/matchup"
require_relative "league/roster"
require_relative "league/scoring_settings"
require_relative "league/settings"
require_relative "league/traded_pick"

module SleeperRb
  module Resources
    ##
    # This class represents a Fantasy Football League and is the access point for associated resources.
    class League
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      ##
      # :method: total_rosters
      # :method: status
      # :method: sport
      # :method: season_type
      # :method: season
      # :method: previous_league_id
      # :method: name
      # :method: league_id
      # :method: draft_id
      # :method: avatar
      # @return [{SleeperRb::Resources::Avatar}[rdoc-ref:SleeperRb::Resources::Avatar]]
      # :method: scoring_settings
      # @return [{SleeperRb::Resources::League::ScoringSettings}[rdoc-ref:SleeperRb::Resources::League::ScoringSettings]]
      # :method: roster_positions
      # @return [Array<{SleeperRb::Utilities::RosterPosition}[rdoc-ref:SleeperRb::Utilities::RosterPosition]>]
      # :method: settings
      # @return [{SleeperRb::Resources::League::Settings}[rdoc-ref:SleeperRb::Resources::League::Settings]]
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
      # :method: rosters
      # Retrieves rosters for the League.
      #
      # @return [Array<{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]>]
      cached_association(:rosters) do
        retrieve_rosters!
      end

      ##
      # :method: users
      # Retrieves users for the League.
      #
      # @return [Array<{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]>]
      cached_association(:users) do
        retrieve_users!
      end

      ##
      # :method: matchups
      # Returns matchups for the League for the given week.
      # :call-seq:
      #   matchups(week_number)
      #
      # @return [Array<{SleeperRb::Resources::League::Matchup}[rdoc-ref:SleeperRb::Resources::League::Matchup]>]
      cached_association(:matchups) do |week|
        retrieve_matchups!(week)
      end

      ##
      # :method: traded_picks
      # Returns all traded draft picks for the League.
      #
      # @return [Array<{SleeperRb::Resources::League::TradedPick}[rdoc-ref:SleeperRb::Resources::League::TradedPick]>]
      cached_association(:traded_picks) do
        retrieve_traded_picks!
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

      def retrieve_users!
        url = "#{BASE_URL}/league/#{league_id}/users"
        response = execute_request(url)
        response.map { |hash| User.new(hash) }
      end

      def retrieve_matchups!(week)
        url = "#{BASE_URL}/league/#{league_id}/matchups/#{week}"
        response = execute_request(url)
        response.map { |hash| Matchup.new(hash.merge(league: self)) }
      end

      def retrieve_traded_picks!
        url = "#{BASE_URL}/league/#{league_id}/traded_picks"
        response = execute_request(url)
        response.map { |hash| TradedPick.new(hash.merge(league: self)) }
      end
    end
  end
end
