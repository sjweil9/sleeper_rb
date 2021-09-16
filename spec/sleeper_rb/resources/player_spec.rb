# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::Player do
  let(:player_url) { "#{SleeperRb::Utilities::Request::BASE_URL}/players/nfl" }

  before { described_class.refresh }

  describe "::all" do
    it "should return all player instances" do
      expect(described_class.all).to all be_an_instance_of(described_class)
    end

    it "should cache results" do
      5.times { described_class.all }
      expect(WebMock).to have_requested(:get, player_url).once
    end
  end

  describe "::refresh" do
    it "should reset cached players" do
      described_class.all
      described_class.refresh.all
      expect(WebMock).to have_requested(:get, player_url).twice
    end
  end

  describe "#initialize" do
    subject { described_class.new(player_params) }

    # rubocop:disable Metrics/BlockLength
    let(:player_params) do
      {
        player_id: "3986",
        birth_country: nil,
        sport: "nfl",
        fantasy_positions: [
          "DB"
        ],
        depth_chart_order: nil,
        last_name: "Richards",
        pandascore_id: nil,
        news_updated: 1_541_280_893_950,
        birth_city: nil,
        birth_date: "1991-01-03",
        depth_chart_position: nil,
        weight: "210",
        full_name: "Jeff Richards",
        yahoo_id: 30_093,
        practice_participation: nil,
        status: "Inactive",
        years_exp: 3,
        position: "CB",
        number: 29,
        injury_start_date: nil,
        college: "Emporia State",
        height: "6'2\"",
        injury_notes: nil,
        gsis_id: "00-0033187",
        birth_state: nil,
        swish_id: nil,
        hashtag: "#JeffRichards-NFL-FA-29",
        age: 29,
        rotoworld_id: nil,
        espn_id: 4_084_949,
        high_school: nil,
        injury_status: nil,
        team: nil,
        metadata: nil,
        sportradar_id: "6775c8ae-1966-43c6-a61a-147ea5d112ff",
        active: true,
        injury_body_part: nil,
        fantasy_data_id: 18_821,
        first_name: "Jeff",
        stats_id: nil,
        rotowire_id: 11_704,
        practice_description: nil
      }
    end
    # rubocop:enable Metrics/BlockLength

    let(:translated_keys) { %i[fantasy_positions position] }

    it "should set the proper values" do
      player_params.each do |key, value|
        next if translated_keys.include?(key)

        expect(subject.send(key)).to eq(value)
      end

      expect(subject.fantasy_positions).to all be_an_instance_of(SleeperRb::Utilities::RosterPosition)
      expect(subject.position).to be_an_instance_of(SleeperRb::Utilities::RosterPosition)
      expect(subject.position.cb?).to eq(true)
    end
  end
end
