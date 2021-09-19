# frozen_string_literal: true

RSpec.describe SleeperRb::Client do
  subject { described_class.new }

  describe "#nfl_state" do
    it "returns the instance of NflState" do
      expect(subject.nfl_state).to eq(SleeperRb::Resources::NflState.instance)
    end
  end

  describe "#user" do
    it "returns a User instance by username" do
      result = subject.user(username: "foo")
      expect(result).to be_an_instance_of(SleeperRb::Resources::User)
      expect(result.username).to eq("foo")
    end

    it "returns a User instance by user_id" do
      result = subject.user(user_id: "ABC123")
      expect(result).to be_an_instance_of(SleeperRb::Resources::User)
      expect(result.user_id).to eq("ABC123")
    end
  end

  describe "#avatar" do
    it "returns an Avatar instance by ID" do
      result = subject.avatar("ABC123")
      expect(result).to be_an_instance_of(SleeperRb::Resources::Avatar)
      expect(result.avatar_id).to eq("ABC123")
    end
  end

  describe "#league" do
    it "returns a League instance by ID" do
      result = subject.league("ABC123")
      expect(result).to be_an_instance_of(SleeperRb::Resources::League)
      expect(result.league_id).to eq("ABC123")
    end
  end

  describe "#draft" do
    it "returns a Draft instance by ID" do
      result = subject.draft("ABC123")
      expect(result).to be_an_instance_of(SleeperRb::Resources::Draft)
      expect(result.draft_id).to eq("ABC123")
    end
  end

  describe "#players" do
    it "should return a PlayerArray with all players" do
      expect(subject.players).to be_an_instance_of(SleeperRb::Resources::PlayerArray)
      expect(subject.players.map(&:player_id).sort).to eq(SleeperRb::Resources::Player.all.map(&:player_id).sort)
    end
  end
end
