# frozen_string_literal: true

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

      cached_attr *FIELDS

      def initialize(opts)
        opts.slice(*FIELDS).each do |key, val|
          instance_variable_set(:"@#{key}", val)
        end
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/league/#{league_id}")
        execute_request(uri)
      end
    end
  end
end
