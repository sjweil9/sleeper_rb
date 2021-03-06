# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      class Roster
        ##
        # Settings for a specific roster in a league, including W/L/D, scoring_data, and waiver info.
        class Settings
          include SleeperRb::Utilities::Cache

          ##
          # :attr_reader: wins

          ##
          # :attr_reader: waiver_position

          ##
          # :attr_reader: waiver_budget_used

          ##
          # :attr_reader: total_moves

          ##
          # :attr_reader: ties

          ##
          # :attr_reader: losses

          ##
          # :attr_reader: fpts_decimal

          ##
          # :attr_reader: fpts_against_decimal

          ##
          # :attr_reader: fpts_against

          ##
          # :attr_reader: fpts

          cached_attr :wins, :waiver_position, :waiver_budget_used, :total_moves, :ties, :losses, :fpts_decimal,
                      :fpts_against_decimal, :fpts_against, :fpts

          skip_refresh :all

          ##
          # @return [Float] All points scored by the roster
          def total_points
            (fpts.to_f + (fpts_decimal.to_f * 0.01)).round(2)
          end

          ##
          # @return [Float] All points scored against the roster
          def total_points_against
            (fpts_against.to_f + (fpts_against_decimal.to_f * 0.01)).round(2)
          end

          ##
          # @return [Float] Percentage of games won by the roster
          def win_pct
            return 0.0 unless [wins, ties, losses].any?(&:positive?)

            ((wins.to_f / (wins + ties + losses)) * 100.0).round(2)
          end

          ##
          # @return [String] Record for the roster in W - L - T format
          def record_string
            "#{wins} - #{losses} - #{ties}"
          end
        end
      end
    end
  end
end
