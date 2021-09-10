# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League::Roster do
  subject { described_class.new(roster_params) }

  let(:roster_params) do
    {
      taxi: nil,
      starters: starter_ids,
      settings: {
        wins: 3,
        waiver_position: 5,
        waiver_budget_used: 0,
        total_moves: 0,
        ties: 1,
        losses: 2,
        fpts: 100,
        fpts_decimal: 25,
        fpts_against: 105,
        fpts_against_decimal: 83
      },
      roster_id: 1,
      reserve: reserve_ids,
      players: player_ids,
      player_map: nil,
      owner_id: owner_id,
      metadata: nil,
      league_id: league_id,
      co_owners: nil
    }
  end

  let(:league_id) { "321412341234123" }
  let(:owner_id) { "190289012093123" }
  let(:starter_ids) { %w[6770 4029 4098 947 1352 1466 2449 3157] }
  let(:player_ids) { %w[1352 1466 2152 2449 3157 3271 3423 4029 4098 6770 6801 6945 7523 7607 7610 947] }
  let(:reserve_ids) { %w[1456] }

  describe "#initialize" do
    it "should set the proper values" do
      expect(subject.roster_id).to eq(1)
      expect(subject.owner_id).to eq(owner_id)
      expect(subject.league_id).to eq(league_id)
      expect(subject.starters).to all be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.starters.map(&:player_id)).to match_array(starter_ids)
      expect(subject.players).to all be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.players.map(&:player_id)).to match_array(player_ids)
      expect(subject.reserve).to all be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.reserve.map(&:player_id)).to match_array(reserve_ids)
    end
  end

  describe "#owner" do
    it "should return the correct User instance" do
      expect(subject.owner).to be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.owner.user_id).to eq(owner_id)
    end
  end
end
