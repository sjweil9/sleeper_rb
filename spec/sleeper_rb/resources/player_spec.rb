# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::Player do
  before do
    stub_request(:get, player_url).to_return(body: player_response)
    described_class.refresh
  end

  let(:player_url) { "https://api.sleeper.app/v1/players/nfl" }
  let(:player_response) do
    File.read(File.expand_path("../../fixtures/player_response.json", File.dirname(__FILE__)))
  end

  describe "::all" do
    it "should return all player instances" do
      expect(described_class.all).to all be_an_instance_of(described_class)
    end

    it "should cache results" do
      5.times { described_class.all }
      expect(WebMock).to have_requested(:get, player_url).once
    end
  end

  describe "::find" do
    let(:player_id) { "3986" }

    it "should retrieve a player by ID" do
      player = described_class.find(player_id)
      expect(player).to be_an_instance_of(SleeperRb::Resources::Player)
      expect(player.player_id).to eq(player_id)
    end
  end

  describe "::refresh" do
    it "should reset cached players" do
      described_class.all
      described_class.refresh.all
      expect(WebMock).to have_requested(:get, player_url).twice
    end
  end
end
