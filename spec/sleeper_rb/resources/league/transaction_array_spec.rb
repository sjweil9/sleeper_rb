# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::TransactionArray do
  subject { described_class.new(transactions) }

  let(:league) { SleeperRb::Resources::League.new(league_id: league_id) }
  let(:league_id) { "737327330413969408" }
  let(:transactions) do
    JSON.parse(
      transaction_response,
      symbolize_names: true
    ).map { |hash| SleeperRb::Resources::League::Transaction.new(hash.merge(league: league)) }
  end
  let(:transaction_response) do
    File.read(File.expand_path("../../../fixtures/transactions_response.json", File.dirname(__FILE__)))
  end

  describe "#trade" do
    it "should return all trades" do
      expect(subject.trade).to be_an_instance_of(described_class)
      expect(subject.trade.size).to eq(1)
      expect(subject.trade.first.transaction_id).to eq("434852362033561600")
    end
  end

  describe "#free_agent" do
    it "should return all FA moves" do
      expect(subject.free_agent).to be_an_instance_of(described_class)
      expect(subject.free_agent.size).to eq(2)
      expect(subject.free_agent.first.transaction_id).to eq("434890120798142464")
      expect(subject.free_agent.last.transaction_id).to eq("434890120798142465")
    end
  end

  describe "#faab" do
    it "should return all FA moves made with FAAB" do
      expect(subject.faab).to be_an_instance_of(described_class)
      expect(subject.faab.size).to eq(1)
      expect(subject.faab.first.transaction_id).to eq("434890120798142465")
    end
  end

  describe "#waiver" do
    it "should return all FA moves made via waiver wire" do
      expect(subject.waiver).to be_an_instance_of(described_class)
      expect(subject.waiver.size).to eq(1)
      expect(subject.waiver.first.transaction_id).to eq("434890120798142464")
    end
  end
end
