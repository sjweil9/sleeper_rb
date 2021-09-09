# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Non-scoring settings for a League instance
      class Settings
        FIELDS = %i[
          max_keepers draft_rounds trade_review_days reserve_allow_dnr capacity_override
          pick_trading disable_trades taxi_years taxi_allow_vets best_ball disable_adds waiver_type bench_lock
          reserve_allow_sus type reserve_allow_cov waiver_clear_days daily_waivers_last_ran waiver_day_of_week
          start_week playoff_teams num_teams reserve_slots playoff_round_type daily_waivers_hour waiver_budget
          reserve_allow_out offseason_adds playoff_seed_type daily_waivers playoff_week_start daily_waivers_days
          league_average_match leg trade_deadline reserve_allow_doubtful taxi_deadline reserve_allow_na taxi_slots
          playoff_type
        ].freeze

        attr_reader *FIELDS

        def initialize(opts)
          opts.slice(*FIELDS).each do |key, val|
            instance_variable_set(:"@#{key}", val)
          end
        end
      end
    end
  end
end
