# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League do
  describe "#initialize" do
    context "when league_id is provided" do
      let(:valid_opts) do
        {
          league_id: "ABC123",
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

      subject { described_class.new(valid_opts) }

      it "should set all allowed values" do
        valid_opts.each do |key, value|
          expect(subject.send(key)).to eq(value)
        end
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

      subject { described_class.new(invalid_opts) }

      it "should raise ArgumentError" do
      end
    end
  end
end
