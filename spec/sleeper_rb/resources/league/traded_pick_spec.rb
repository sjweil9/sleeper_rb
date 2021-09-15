# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::TradedPick do
  subject { described_class.new(valid_opts.merge(league: league)) }

  let(:league) { SleeperRb::Resources::League.new(league_id: league_id) }
  let(:league_id) { "735284283123548160" }
  let(:valid_opts) do
    {
      season: "2019",
      round: 5,
      roster_id: 1,
      previous_owner_id: 1,
      owner_id: 2
    }
  end

  describe "#initialize" do
    it "should set the proper values" do
      valid_opts.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end
    end
  end

  context "associations" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    describe "#original_roster" do
      it "should return the correct roster" do
        expect(subject.original_roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
        expect(subject.original_roster.roster_id).to eq(1)
      end
    end

    describe "#previous_roster" do
      it "should return the correct roster" do
        expect(subject.previous_roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
        expect(subject.previous_roster.roster_id).to eq(1)
      end
    end

    describe "#current_roster" do
      it "should return the correct roster" do
        expect(subject.current_roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
        expect(subject.current_roster.roster_id).to eq(2)
      end
    end
  end
end
