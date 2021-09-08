# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::User do
  before do
    stub_request(:get, username_url).to_return(status: 200, body: user_response)
    stub_request(:get, user_id_url).to_return(status: 200, body: user_response)
    stub_request(:get, bad_url).to_return(status: 404)
  end

  let(:username_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{username}") }
  let(:user_id_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{user_id}") }
  let(:bad_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{bad_id}") }
  let(:username) { "foobar" }
  let(:user_id) { "469586445502246912" }
  let(:avatar) { "c8de9e651b19331f6eae4f9f26164107" }
  let(:bad_id) { "219082094128012321" }

  let(:user_response) do
    {
      verification: nil,
      username: username,
      user_id: user_id,
      token: nil,
      summoner_region: nil,
      summoner_name: nil,
      solicitable: nil,
      real_name: nil,
      phone: nil,
      pending: nil,
      notifications: nil,
      is_bot: false,
      email: nil,
      display_name: username,
      deleted: nil,
      data_updated: nil,
      currencies: nil,
      created: nil,
      cookies: nil,
      avatar: avatar
    }.to_json
  end

  describe "#retrieve_values!" do
    context "when initialized with username" do
      subject { described_class.new(username: username) }

      it "should set all proper values" do
        expect(Net::HTTP).to receive(:get_response).with(username_url).once.and_call_original
        expect(subject.username).to eq(username)
        expect(subject.user_id).to eq(user_id)
        expect(subject.avatar).to be_an_instance_of(SleeperRb::Resources::Avatar)
        expect(subject.avatar.avatar_id).to eq(avatar)
        expect(subject.display_name).to eq(username)
      end
    end

    context "when initialized with user_id" do
      subject { described_class.new(user_id: user_id) }

      it "should set all proper values" do
        expect(Net::HTTP).to receive(:get_response).with(user_id_url).once.and_call_original
        expect(subject.username).to eq(username)
        expect(subject.user_id).to eq(user_id)
        expect(subject.avatar).to be_an_instance_of(SleeperRb::Resources::Avatar)
        expect(subject.avatar.avatar_id).to eq(avatar)
        expect(subject.display_name).to eq(username)
      end
    end

    context "when initialized with an invalid user_id" do
      subject { described_class.new(user_id: bad_id) }

      it "should raise NotFound" do
        expect { subject.display_name }.to raise_error(SleeperRb::NotFound)
      end
    end
  end

  describe "#leagues" do
    before { stub_request(:get, leagues_url).to_return(body: leagues_response) }
    let(:leagues_url) { "#{SleeperRb::Utilities::Request::BASE_URL}/user/#{user_id}/leagues/nfl/#{year}" }
    let(:year) { 2021 }
    let(:league_one_id) { "ABC123" }
    let(:league_two_id) { "123XYZ" }
    let(:draft_one_id) { "CBA123" }
    let(:draft_two_id) { "ZYX321" }

    # rubocop:disable Naming/VariableNumber, Metrics/BlockLength
    let(:leagues_response) do
      [
        {
          total_rosters: 8,
          status: "in_season",
          sport: "nfl",
          shard: 630,
          settings: {
            max_keepers: 1,
            draft_rounds: 3,
            trade_review_days: 2,
            reserve_allow_dnr: 0,
            capacity_override: 0,
            pick_trading: 1,
            disable_trades: 1,
            taxi_years: 0,
            taxi_allow_vets: 0,
            best_ball: 1,
            disable_adds: 1,
            waiver_type: 0,
            bench_lock: 0,
            reserve_allow_sus: 0,
            type: 0,
            reserve_allow_cov: 0,
            waiver_clear_days: 2,
            daily_waivers_last_ran: 29,
            waiver_day_of_week: 2,
            start_week: 1,
            playoff_teams: 6,
            num_teams: 8,
            reserve_slots: 0,
            playoff_round_type: 0,
            daily_waivers_hour: 0,
            waiver_budget: 100,
            reserve_allow_out: 0,
            offseason_adds: 0,
            playoff_seed_type: 0,
            daily_waivers: 0,
            playoff_week_start: 0,
            daily_waivers_days: 1093,
            league_average_match: 0,
            leg: 1,
            trade_deadline: 11,
            reserve_allow_doubtful: 0,
            taxi_deadline: 0,
            reserve_allow_na: 0,
            taxi_slots: 0,
            playoff_type: 0
          },
          season_type: "regular",
          season: 2021,
          scoring_settings: {
            pass_2pt: 2,
            pass_int: -1,
            fgmiss: -1,
            rec_yd: 0.10000000149011612,
            xpmiss: -1,
            fgm_30_39: 3,
            blk_kick: 2,
            pts_allow_7_13: 4,
            ff: 1,
            fgm_20_29: 3,
            fgm_40_49: 4,
            pts_allow_1_6: 7,
            st_fum_rec: 1,
            def_st_ff: 1,
            st_ff: 1,
            pts_allow_28_34: -1,
            fgm_50p: 5,
            fum_rec: 2,
            def_td: 6,
            fgm_0_19: 3,
            int: 2,
            pts_allow_0: 10,
            pts_allow_21_27: 0,
            rec_2pt: 2,
            rec: 1,
            xpm: 1,
            st_td: 6,
            def_st_fum_rec: 1,
            def_st_td: 6,
            sack: 1,
            fum_rec_td: 6,
            rush_2pt: 2,
            rec_td: 6,
            pts_allow_35p: -4,
            pts_allow_14_20: 1,
            rush_yd: 0.10000000149011612,
            pass_yd: 0.03999999910593033,
            pass_td: 4,
            rush_td: 6,
            fum_lost: -2,
            fum: -1,
            safe: 2
          },
          roster_positions: %w[QB RB RB WR WR TE FLEX FLEX BN BN BN BN BN BN],
          previous_league_id: nil,
          name: "Foo League",
          metadata: {
            auto_continue: "off"
          },
          loser_bracket_id: nil,
          league_id: league_one_id,
          draft_id: draft_one_id,
          display_order: 0,
          company_id: nil,
          bracket_id: nil,
          avatar: nil
        },
        {
          total_rosters: 8,
          status: "in_season",
          sport: "nfl",
          shard: 92,
          settings: {
            max_keepers: 1,
            draft_rounds: 3,
            trade_review_days: 2,
            reserve_allow_dnr: 0,
            capacity_override: 0,
            pick_trading: 1,
            disable_trades: 1,
            taxi_years: 0,
            taxi_allow_vets: 0,
            best_ball: 1,
            disable_adds: 1,
            waiver_type: 0,
            bench_lock: 0,
            reserve_allow_sus: 0,
            type: 0,
            reserve_allow_cov: 0,
            waiver_clear_days: 2,
            daily_waivers_last_ran: 29,
            waiver_day_of_week: 2,
            start_week: 1,
            playoff_teams: 6,
            num_teams: 8,
            reserve_slots: 0,
            playoff_round_type: 0,
            daily_waivers_hour: 0,
            waiver_budget: 100,
            reserve_allow_out: 0,
            offseason_adds: 0,
            playoff_seed_type: 0,
            daily_waivers: 0,
            playoff_week_start: 0,
            daily_waivers_days: 1093,
            league_average_match: 0,
            leg: 1,
            trade_deadline: 11,
            reserve_allow_doubtful: 0,
            taxi_deadline: 0,
            reserve_allow_na: 0,
            taxi_slots: 0,
            playoff_type: 0
          },
          season_type: "regular",
          season: 2021,
          scoring_settings: {
            pass_2pt: 2,
            pass_int: -1,
            fgmiss: -1,
            rec_yd: 0.10000000149011612,
            xpmiss: -1,
            fgm_30_39: 3,
            blk_kick: 2,
            pts_allow_7_13: 4,
            ff: 1,
            fgm_20_29: 3,
            fgm_40_49: 4,
            pts_allow_1_6: 7,
            st_fum_rec: 1,
            def_st_ff: 1,
            st_ff: 1,
            pts_allow_28_34: -1,
            fgm_50p: 5,
            fum_rec: 2,
            def_td: 6,
            fgm_0_19: 3,
            int: 2,
            pts_allow_0: 10,
            pts_allow_21_27: 0,
            rec_2pt: 2,
            rec: 1,
            xpm: 1,
            st_td: 6,
            def_st_fum_rec: 1,
            def_st_td: 6,
            sack: 1,
            fum_rec_td: 6,
            rush_2pt: 2,
            rec_td: 6,
            pts_allow_35p: -4,
            pts_allow_14_20: 1,
            rush_yd: 0.10000000149011612,
            pass_yd: 0.03999999910593033,
            pass_td: 4,
            rush_td: 6,
            fum_lost: -2,
            fum: -1,
            safe: 2
          },
          roster_positions: %w[QB RB RB WR WR TE FLEX FLEX BN BN BN BN BN BN],
          previous_league_id: nil,
          name: "Bar League",
          metadata: {
            auto_continue: "off"
          },
          loser_bracket_id: nil,
          league_id: league_two_id,
          draft_id: draft_two_id,
          display_order: 0,
          company_id: nil,
          bracket_id: nil,
          avatar: nil
        }
      ].to_json
    end
    # rubocop:enable Naming/VariableNumber, Metrics/BlockLength

    subject { described_class.new(user_id: user_id) }

    it "should return all leagues for a user by season" do
      leagues = subject.leagues(2021)
      expect(leagues).to all be_an_instance_of(SleeperRb::Resources::League)
      expect(leagues.first.league_id).to eq(league_one_id)
      expect(leagues.last.league_id).to eq(league_two_id)
    end
  end
end
