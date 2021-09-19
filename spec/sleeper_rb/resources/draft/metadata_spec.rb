# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft::Metadata do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
      scoring_type: "ppr",
      offering_user_id: "469548265499521025",
      offering_slot: "1",
      nominating_user_id: "469548265499521024",
      nominating_slot: "1",
      nominated_player_id: "7591",
      name: "WH Auction BBall 2",
      hovered_player_id: "7591",
      highest_offer: "1",
      description: ""
    }
  end

  describe "#initialize" do
    it "should set the proper values" do
      valid_opts.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end
    end
  end

  describe "#offering_user" do
    it "should return the appropriate User object" do
      expect(subject.offering_user).to be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.offering_user.user_id).to eq("469548265499521025")
    end
  end

  describe "#nominating_user" do
    it "should return the appropriate User object" do
      expect(subject.nominating_user).to be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.nominating_user.user_id).to eq("469548265499521024")
    end
  end

  describe "#nominated_player" do
    it "should return the appropriate Player object" do
      expect(subject.nominated_player).to be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.nominated_player.player_id).to eq("7591")
    end
  end

  describe "#hovered_player" do
    it "should return the appropriate Player object" do
      expect(subject.hovered_player).to be_an_instance_of(SleeperRb::Resources::Player)
      expect(subject.hovered_player.player_id).to eq("7591")
    end
  end
end
