# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::Transaction::WaiverBudget do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
      sender: 1,
      receiver: 2,
      amount: 55,
      transaction: transaction
    }
  end
  let(:transaction) do
    SleeperRb::Resources::League::Transaction.new(league: league)
  end
  let(:league) do
    SleeperRb::Resources::League.new(league_id: league_id)
  end
  let(:league_id) { "735284283123548160" }

  before do
    stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
  end

  let(:rosters_response) do
    File.read(File.expand_path("../../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
  end

  describe "#initialize" do
    it "sets the proper values" do
      valid_opts.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end
    end
  end

  describe "#sending_roster" do
    it "returns the appropriate roster object" do
      expect(subject.sending_roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
      expect(subject.sending_roster.roster_id).to eq(subject.sender)
    end
  end

  describe "#receiving_roster" do
    it "returns the appropriate roster object" do
      expect(subject.receiving_roster).to be_an_instance_of(SleeperRb::Resources::League::Roster)
      expect(subject.receiving_roster.roster_id).to eq(subject.receiver)
    end
  end
end
