module SleeperRb
  module Resources
    class League
      class Roster
        class Settings
          include SleeperRb::Utilities::Cache

          cached_attr :wins, :waiver_positions, :waiver_budget_used, :total_moves, :ties, :losses, :fpts_decimal,
                       :fpts_against_decimal, :fpts_against, :fpts

          def total_points
            fpts.to_f + (fpts_decimal.to_f * 0.01)
          end

          def total_points_against
            fpts_against.to_f + (fpts_against_decimal.to_f * 0.01)
          end

          def win_pct
            ((wins.to_f / (wins + ties + losses).to_f) * 100.0).round(2)
          end

          def record_string
            # W - L - T
            "#{wins} - #{losses} - #{ties}"
          end

          private

          def values
            {}
          end
        end
      end
    end
  end
end