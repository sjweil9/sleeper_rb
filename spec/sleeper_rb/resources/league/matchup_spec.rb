# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::Matchup do
  subject { described_class.new(valid_params) }

  let(:valid_params) { base_params.merge(league: league) }
  let(:base_params) do
    json = File.read(File.expand_path("../../../fixtures/matchups_response.json", File.dirname(__FILE__)))
    JSON.parse(json, symbolize_names: true).first
  end
  let(:league) { SleeperRb::Resources::League.new(league_id: league_id) }
  let(:league_id) { "735284283123548160" }

  describe "#initialize" do
    it "should set the proper values" do
      valid_params.each do |key, value|
        if %i[starters players].include?(key)
          expect(subject.send(key)).to all be_an_instance_of(SleeperRb::Resources::Player)
          expect(subject.send(key).map(&:player_id)).to eq(value)
        else
          expect(subject.send(key)).to eq(value)
        end
      end
    end
  end

  describe "#roster" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    it "should retrieve the appropriate roster from the league" do
      expect(league).to receive(:rosters).once.and_call_original
      expect(subject.roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
      expect(subject.roster.roster_id).to eq(1)
    end
  end
end
