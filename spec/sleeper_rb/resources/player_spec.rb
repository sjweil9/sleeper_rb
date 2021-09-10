# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::Player do
  before { stub_request(:get, "https://api.sleeper.app/v1/players/nfl").to_return(player_response) }

  let(:player_response) do

  end

  describe "::all" do
    it "should return all player instances" do

    end
  end

  describe "::find" do

  end
end