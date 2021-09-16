# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # A specific NFL player with general information about roster position, physical attributes, team, etc.
    class Player
      extend SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      class << self
        ##
        # Ensuring there is one source of players so the heavy endpoint need not be called frequently.
        #
        # @return [Array<{SleeperRb::Resources::Player}[rdoc-ref:SleeperRb::Resources::Player]>]
        def all
          @all ||= PlayerArray.new(player_hashes.reduce([]) do |array, (_player_id, player_hash)|
            array << new(player_hash)
          end)
        end

        ##
        # Resets the values for all players.
        #
        # @return [self]
        def refresh
          @all = nil
          @player_hashes = nil
          self
        end

        def player_hashes
          @player_hashes ||= retrieve_players!
        end

        private

        def retrieve_players!
          url = "#{BASE_URL}/players/nfl"
          execute_request(url)
        end
      end

      ##
      # :attr_reader: hashtag

      ##
      # :attr_reader: depth_chart_position

      ##
      # :attr_reader: status

      ##
      # :attr_reader: sport

      ##
      # :attr_reader: number

      ##
      # :attr_reader: injury_start_date

      ##
      # :attr_reader: weight

      ##
      # :attr_reader: practice_participation

      ##
      # :attr_reader: sportradar_id

      ##
      # :attr_reader: team

      ##
      # :attr_reader: last_name

      ##
      # :attr_reader: college

      ##
      # :attr_reader: fantasy_data_id

      ##
      # :attr_reader: full_name

      ##
      # :attr_reader: injury_status

      ##
      # :attr_reader: player_id

      ##
      # :attr_reader: height

      ##
      # :attr_reader: age

      ##
      # :attr_reader: stats_id

      ##
      # :attr_reader: birth_country

      ##
      # :attr_reader: espn_id

      ##
      # :attr_reader: first_name

      ##
      # :attr_reader: active

      ##
      # :attr_reader: depth_chart_order

      ##
      # :attr_reader: years_exp

      ##
      # :attr_reader: rotowire_id

      ##
      # :attr_reader: yahoo_id

      ##
      # :attr_reader: pandascore_id

      ##
      # :attr_reader: news_updated

      ##
      # :attr_reader: birth_city

      ##
      # :attr_reader: birth_date

      ##
      # :attr_reader: injury_notes

      ##
      # :attr_reader: gsis_id

      ##
      # :attr_reader: birth_state

      ##
      # :attr_reader: swish_id

      ##
      # :attr_reader: high_school

      ##
      # :attr_reader: metadata

      ##
      # :attr_reader: injury_body_part

      ##
      # :attr_reader: practice_description

      ##
      # :method: fantasy_positions
      # All fantasy positions for which the player is eligible.
      #
      # @return [Array<{SleeperRb::Utilities::RosterPosition}[rdoc-ref:SleeperRb::Utilities::RosterPosition]>]

      ##
      # :method: position
      # Primary position for the player.
      #
      # @return [{SleeperRb::Utilities::RosterPosition}[rdoc-ref:SleeperRb::Utilities::RosterPosition]]

      cached_attr :hashtag, :depth_chart_position, :status, :sport, :number, :injury_start_date, :weight,
                  :practice_participation, :sportradar_id, :team, :last_name, :college, :fantasy_data_id, :full_name,
                  :injury_status, :player_id, :height, :age, :stats_id, :birth_country, :espn_id, :first_name, :active,
                  :depth_chart_order, :years_exp, :rotowire_id, :rotoworld_id, :yahoo_id, :pandascore_id, :news_updated,
                  :birth_city, :birth_date, :injury_notes, :gsis_id, :birth_state, :swish_id, :high_school, :metadata,
                  :injury_body_part, :practice_description,
                  fantasy_positions: ->(array) { array&.map { |pos| SleeperRb::Utilities::RosterPosition.new(pos) } },
                  position: ->(pos) { pos ? SleeperRb::Utilities::RosterPosition.new(pos) : nil }

      private

      def retrieve_values!
        self.class.player_hashes[@player_id.to_sym]
      end
    end
  end
end
