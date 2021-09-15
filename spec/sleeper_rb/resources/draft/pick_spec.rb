# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft::Pick do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    json = File.read(File.expand_path("../../../fixtures/draft_picks_response.json", File.dirname(__FILE__)))
    parsed = JSON.parse(json, symbolize_names: true)
    parsed.first.merge(draft: draft)
  end

  let(:draft) { SleeperRb::Resources::Draft.new(draft_id: draft_id, league: league) }
  let(:league) { SleeperRb::Resources::League.new(league_id: league_id) }
  let(:draft_id) { "735284283798888448" }
  let(:league_id) { "737785373232623616" }
  let(:translated_keys) { %i[metadata] }

  describe "#initialize" do
    it "sets the proper values" do
      valid_opts.reject { |key, _val| translated_keys.include?(key) }.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end

      expect(subject.metadata).to be_an_instance_of(SleeperRb::Resources::Draft::Pick::Metadata)
    end
  end

  describe "#player" do
    it "returns the player instance" do
      expect(subject.player).to be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.player.player_id).to eq(subject.player_id)
    end
  end

  describe "#roster" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    it "returns the correct roster, retrieved from leagues" do
      expect(subject.roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
      expect(subject.roster.roster_id).to eq(subject.roster_id)
    end
  end

  describe "#user" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/users").to_return(body: users_response)
    end

    let(:users_response) do
      File.read(File.expand_path("../../../fixtures/users_response.json", File.dirname(__FILE__)))
    end

    it "returns the correct user, retrieved from leagues" do
      expect(subject.user).to be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.user.user_id).to eq(subject.picked_by)
    end
  end
end
