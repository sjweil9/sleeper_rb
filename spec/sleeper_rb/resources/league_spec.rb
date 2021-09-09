# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League do
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

  describe "#initialize" do
    context "when league_id is provided" do
      let(:translated_keys) { %i[settings roster_positions scoring_settings] }

      it "should set all allowed values" do
        valid_opts.each do |key, value|
          next if translated_keys.include?(key)

          expect(subject.send(key)).to eq(value)
        end
        expect(subject.scoring_settings).to be_an_instance_of(SleeperRb::Resources::League::ScoringSettings)
        expect(subject.settings).to be_an_instance_of(SleeperRb::Resources::League::Settings)
        expect(subject.roster_positions).to all be_an_instance_of(SleeperRb::Resources::League::RosterPosition)
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
end
