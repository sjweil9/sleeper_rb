# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League::Settings do
  let(:valid_settings) do
    {
      max_keepers: 1, draft_rounds: 3, trade_review_days: 2, reserve_allow_dnr: 0, capacity_override: 0,
      pick_trading: 1, disable_trades: 1, taxi_years: 0, taxi_allow_vets: 0, best_ball: 1, disable_adds: 1,
      waiver_type: 0, bench_lock: 0, reserve_allow_sus: 0, type: 0, reserve_allow_cov: 0, waiver_clear_days: 2,
      daily_waivers_last_ran: 29, waiver_day_of_week: 2, start_week: 1, playoff_teams: 6, num_teams: 8,
      playoff_round_type: 0, daily_waivers_hour: 0, waiver_budget: 100, reserve_allow_out: 0, offseason_adds: 0,
      playoff_seed_type: 0, daily_waivers: 0, playoff_week_start: 0, daily_waivers_days: 1093, league_average_match: 0,
      leg: 1, trade_deadline: 11, reserve_allow_doubtful: 0, taxi_deadline: 0, reserve_allow_na: 0, taxi_slots: 0,
      reserve_slots: 0, playoff_type: 0
    }
  end

  subject { described_class.new(valid_settings) }

  it "should set all valid fields as instance variables" do
    valid_settings.each do |key, val|
      expect(subject.send(key)).to eq(subject.send(:cached_attrs)[key].call(val))
    end
  end
end
