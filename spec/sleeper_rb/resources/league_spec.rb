# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League do
  let(:valid_opts) do
    {
      league_id: league_id,
      status: "in_season",
      sport: "nfl",
      total_rosters: 10,
      settings: {},
      season_type: "regular",
      season: 2021,
      scoring_settings: {},
      roster_positions: [],
      previous_league_id: "XYZ123",
      draft_id: "QED345",
      avatar: "ABC123CYZ"
    }
  end

  let(:league_id) { "ABC123" }

  subject { described_class.new(valid_opts) }

  describe "#initialize" do
    context "when league_id is provided" do
      let(:translated_keys) { %i[settings roster_positions scoring_settings avatar] }

      it "should set all allowed values" do
        valid_opts.each do |key, value|
          next if translated_keys.include?(key)

          expect(subject.send(key)).to eq(value)
        end
        expect(subject.scoring_settings).to be_an_instance_of(SleeperRb::Resources::League::ScoringSettings)
        expect(subject.settings).to be_an_instance_of(SleeperRb::Resources::League::Settings)
        expect(subject.roster_positions).to all be_an_instance_of(SleeperRb::Utilities::RosterPosition)
        expect(subject.avatar).to be_an_instance_of(SleeperRb::Resources::Avatar)
        expect(subject.avatar.avatar_id).to eq("ABC123CYZ")
      end
    end

    context "when league_id is not provided" do
      let(:invalid_opts) do
        {
          total_rosters: 10,
          status: "in_season",
          sport: "nfl"
        }
      end

      it "should raise ArgumentError" do
        expect { described_class.new(invalid_opts) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#users" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/users").to_return(body: users_response)
    end

    let(:users_response) do
      File.read(File.expand_path("../../fixtures/users_response.json", File.dirname(__FILE__)))
    end

    it "should return all users for the league" do
      expect(subject.users).to be_an_instance_of(SleeperRb::Resources::UserArray)
      expect(subject.users).to all be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.users.size).to eq(8)
      expect(subject.users.first.user_id).to eq("374409574377324544")
      expect(subject.users.last.user_id).to eq("737182541722861568")
    end
  end

  describe "#rosters" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    it "should return all rosters for the league" do
      expect(subject.rosters).to all be_an_instance_of(SleeperRb::Resources::League::Roster)
      expect(subject.rosters.size).to eq(8)
      expect(subject.rosters.first.owner_id).to eq("469586445502246912")
    end
  end

  describe "#matchups" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/matchups/1").to_return(body: matchups_response)
    end

    let(:matchups_response) do
      File.read(File.expand_path("../../fixtures/matchups_response.json", File.dirname(__FILE__)))
    end

    it "should return all matchups for the league for that week" do
      expect(subject.matchups(1)).to all be_an_instance_of(SleeperRb::Resources::League::Matchup)
      expect(subject.matchups(1).size).to eq(8)
      expect(subject.matchups(1).first.roster_id).to eq(1)
    end
  end

  describe "#traded_picks" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/traded_picks").to_return(body: picks_response)
    end

    let(:picks_response) do
      File.read(File.expand_path("../../fixtures/traded_picks_response.json", File.dirname(__FILE__)))
    end

    it "should return all traded picks for the league" do
      expect(subject.traded_picks).to be_an_instance_of(SleeperRb::Resources::TradedPickArray)
      expect(subject.traded_picks).to all be_an_instance_of(SleeperRb::Resources::TradedPick)
      expect(subject.traded_picks.first.previous_owner_id).to eq(1)
    end
  end

  describe "#drafts" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/drafts").to_return(body: drafts_response)
    end

    let(:drafts_response) do
      File.read(File.expand_path("../../fixtures/drafts_response.json", File.dirname(__FILE__)))
    end

    it "should return all drafts for the league" do
      expect(subject.drafts).to all be_an_instance_of(SleeperRb::Resources::Draft)
      expect(subject.drafts.first.draft_id).to eq("737785377116553216")
      expect(subject.drafts.last.draft_id).to eq("735284283798888448")
    end
  end
end
