# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Non-scoring settings for a League instance
      class Settings
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: max_keepers

        ##
        # :attr_reader: draft_rounds

        ##
        # :attr_reader: trade_review_days

        ##
        # :attr_reader: reserve_allow_dnr

        ##
        # :attr_reader: capacity_override

        ##
        # :attr_reader: pick_trading

        ##
        # :attr_reader: disable_trades

        ##
        # :attr_reader: taxi_years

        ##
        # :attr_reader: taxi_allow_vets

        ##
        # :attr_reader: best_ball

        ##
        # :attr_reader: disable_adds

        ##
        # :attr_reader: waiver_type

        ##
        # :attr_reader: bench_lock

        ##
        # :attr_reader: reserve_allow_sus

        ##
        # :attr_reader: type

        ##
        # :attr_reader: reserve_allow_cov

        ##
        # :attr_reader: waiver_clear_days

        ##
        # :attr_reader: daily_waivers_last_ran

        ##
        # :attr_reader: waiver_day_of_week

        ##
        # :attr_reader: start_week

        ##
        # :attr_reader: playoff_teams

        ##
        # :attr_reader: num_teams

        ##
        # :attr_reader: reserve_slots

        ##
        # :attr_reader: playoff_round_type

        ##
        # :attr_reader: daily_waivers_hours

        ##
        # :attr_reader: waiver_budget

        ##
        # :attr_reader: reserve_allow_out

        ##
        # :attr_reader: offseason_adds

        ##
        # :attr_reader: playoff_seed_type

        ##
        # :attr_reader: daily_waivers

        ##
        # :attr_reader: playoff_week_start

        ##
        # :attr_reader: daily_waivers_days

        ##
        # :attr_reader: league_average_match

        ##
        # :attr_reader: leg

        ##
        # :attr_reader: trade_deadline

        ##
        # :attr_reader: reserve_allow_doubtful

        ##
        # :attr_reader: taxi_deadline

        ##
        # :attr_reader: reserve_allow_na

        ##
        # :attr_reader: taxi_slots

        ##
        # :attr_reader: playoff_type

        FIELDS = %i[
          max_keepers draft_rounds trade_review_days reserve_allow_dnr capacity_override
          pick_trading disable_trades taxi_years taxi_allow_vets best_ball disable_adds waiver_type bench_lock
          reserve_allow_sus type reserve_allow_cov waiver_clear_days daily_waivers_last_ran waiver_day_of_week
          start_week playoff_teams num_teams reserve_slots playoff_round_type daily_waivers_hour waiver_budget
          reserve_allow_out offseason_adds playoff_seed_type daily_waivers playoff_week_start daily_waivers_days
          league_average_match leg trade_deadline reserve_allow_doubtful taxi_deadline reserve_allow_na taxi_slots
          playoff_type
        ].freeze

        cached_attr(*FIELDS)

        skip_refresh :all
      end
    end
  end
end
