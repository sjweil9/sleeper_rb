# frozen_string_literal: true

require_relative "league/roster_position"
require_relative "league/scoring_settings"
require_relative "league/settings"

module SleeperRb
  module Resources
    ##
    # This class represents a Fantasy Football League and is the access point for associated resources.
    class League
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      FIELDS = %i[
        total_rosters status sport settings season_type season scoring_settings roster_positions previous_league_id
        name league_id draft_id avatar
      ].freeze

      TRANSLATED_FIELDS = {
        scoring_settings: ->(settings) { ScoringSettings.new(settings) },
        roster_positions: ->(positions) { positions.map { |pos| RosterPosition.new(pos) } },
        settings: ->(settings) { Settings.new(settings) }
      }.freeze

      cached_attr(*FIELDS)

      ##
      # Create a new League instance with at least league_id. Any other valid provided attributes
      # will be cached as instance variables.
      def initialize(opts)
        raise ArgumentError, "must provide league_id" unless opts[:league_id]

        opts.slice(*FIELDS).each do |key, val|
          instance_variable_set(:"@#{key}", val)
        end
        opts.slice(*TRANSLATED_FIELDS.keys).each do |key, val|
          lambda = TRANSLATED_FIELDS[key]
          instance_variable_set(:"@#{key}", lambda.call(val))
        end
      end

      RosterPosition::VALID_ROSTER_POSITIONS.each do |pos|
        define_method(pos) { roster_positions.select(&:"#{pos}?").size }
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/league/#{league_id}")
        response = execute_request(uri)
        TRANSLATED_FIELDS.each do |field, lambda|
          response[field] = lambda.call(response[field])
        end
        response
      end
    end
  end
end
