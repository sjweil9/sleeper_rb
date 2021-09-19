# frozen-string-literal: true

module SleeperRb
  module Resources
    class Draft
      class Pick
        ##
        # Metadata associated with a specific draft pick.
        class Metadata
          include SleeperRb::Utilities::Cache

          ##
          # :attr_reader: years_exp

          ##
          # :attr_reader: team

          ##
          # :attr_reader: status

          ##
          # :attr_reader: sport

          ##
          # :attr_reader: player_id

          ##
          # :attr_reader: number

          ##
          # :attr_reader: news_updated

          ##
          # :attr_reader: last_name

          ##
          # :attr_reader: injury_status

          ##
          # :attr_reader: first_name

          ##
          # :method: position
          #
          # @return [{SleeperRb::Utilities::RosterPosition}[rdoc-ref:SleeperRb::Utilities::RosterPosition]]

          cached_attr :years_exp, :team, :status, :sport, :player_id, :number, :last_name, :injury_status,
                      :first_name, position: ->(position) { SleeperRb::Utilities::RosterPosition.new(position) },
                                   news_updated: :timestamp

          skip_refresh :all

          ##
          # Returns the combined first and last name.
          #
          # @return [String]
          def full_name
            [first_name, last_name].join(" ")
          end
        end
      end
    end
  end
end
