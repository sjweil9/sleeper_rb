# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::Transaction do
  let(:trade) { described_class.new(trade_opts.merge(league: league)) }
  let(:faab) { described_class.new(faab_opts.merge(league: league)) }
  let(:waiver) { described_class.new(waiver_opts.merge(league: league)) }

  let(:league) { SleeperRb::Resources::League.new(league_id: league_id) }
  let(:league_id) { "735284283123548160" }
  let(:trade_opts) do
    parsed_transactions.detect { |hash| hash[:type] == "trade" }
  end
  let(:faab_opts) do
    parsed_transactions.detect { |hash| hash[:type] == "free_agent" && hash.dig(:settings, :waiver_bid) }
  end
  let(:waiver_opts) do
    parsed_transactions.detect { |hash| hash[:type] == "free_agent" && !hash.dig(:settings, :waiver_bid) }
  end
  let(:parsed_transactions) do
    json = File.read(File.expand_path("../../../fixtures/transactions_response.json", File.dirname(__FILE__)))
    JSON.parse(json, symbolize_names: true)
  end

  subject { trade }

  describe "#initialize" do
    let(:translated_keys) { %i[settings metadata draft_picks waiver_budget] }

    context "with a faab transaction" do
      it "should set the proper values" do
        faab_opts.each do |key, value|
          expect(faab.send(key)).to eq(subject.send(:cached_attrs)[key].call(value)) unless translated_keys.include?(key)
        end

        expect(faab.settings).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Settings)
        expect(faab.metadata).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Metadata)
        expect(faab.draft_picks).to be_an_instance_of(SleeperRb::Resources::TradedPickArray)
        expect(faab.waiver_budget).to all be_an_instance_of(SleeperRb::Resources::League::Transaction::WaiverBudget)
      end
    end

    context "with a waiver transaction" do
      it "should set the proper values" do
        waiver_opts.each do |key, value|
          expect(waiver.send(key)).to eq(subject.send(:cached_attrs)[key].call(value)) unless translated_keys.include?(key)
        end

        expect(waiver.settings).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Settings)
        expect(waiver.metadata).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Metadata)
        expect(waiver.draft_picks).to be_an_instance_of(SleeperRb::Resources::TradedPickArray)
        expect(waiver.waiver_budget).to all be_an_instance_of(SleeperRb::Resources::League::Transaction::WaiverBudget)
      end
    end

    context "with a trade transaction" do
      it "should set the proper values" do
        trade_opts.each do |key, value|
          expect(trade.send(key)).to eq(subject.send(:cached_attrs)[key].call(value)) unless translated_keys.include?(key)
        end

        expect(trade.settings).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Settings)
        expect(trade.metadata).to be_an_instance_of(SleeperRb::Resources::League::Transaction::Metadata)
        expect(trade.draft_picks).to be_an_instance_of(SleeperRb::Resources::TradedPickArray)
        expect(trade.waiver_budget).to all be_an_instance_of(SleeperRb::Resources::League::Transaction::WaiverBudget)
      end
    end
  end

  describe "#rosters" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    it "should return all rosters associated with the transaction" do
      expect(subject.rosters).to be_an_instance_of(SleeperRb::Resources::League::RosterArray)
      expect(subject.rosters.map(&:roster_id).sort).to eq(subject.roster_ids.sort)
    end
  end

  describe "#consenting_rosters" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/rosters").to_return(body: rosters_response)
    end

    let(:rosters_response) do
      File.read(File.expand_path("../../../fixtures/rosters_response.json", File.dirname(__FILE__)))
    end

    it "should return all rosters associated with the transaction" do
      expect(subject.consenting_rosters).to be_an_instance_of(SleeperRb::Resources::League::RosterArray)
      expect(subject.consenting_rosters.map(&:roster_id).sort).to eq(subject.consenter_ids.sort)
    end
  end

  describe "#user" do
    before do
      stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/league/#{league_id}/users").to_return(body: users_response)
    end

    let(:users_response) do
      File.read(File.expand_path("../../../fixtures/users_response.json", File.dirname(__FILE__)))
    end

    it "should return the user who created the league" do
      expect(subject.user).to be_an_instance_of(SleeperRb::Resources::User)
      expect(subject.user.user_id).to eq(subject.creator)
    end
  end

  describe "#trade?" do
    it "returns true if transaction is a trade" do
      expect(trade.trade?).to eq(true)
      expect(faab.trade?).to eq(false)
      expect(waiver.trade?).to eq(false)
    end
  end

  describe "#free_agent?" do
    it "returns true if transaction is a FA pickup" do
      expect(trade.free_agent?).to eq(false)
      expect(faab.free_agent?).to eq(true)
      expect(waiver.free_agent?).to eq(true)
    end
  end

  describe "#faab?" do
    it "returns true if transaction is a FAAB acquisition" do
      expect(trade.faab?).to eq(false)
      expect(faab.faab?).to eq(true)
      expect(waiver.faab?).to eq(false)
    end
  end

  describe "#waiver?" do
    it "returns true if transaction is a waiver wire pickup" do
      expect(trade.waiver?).to eq(false)
      expect(faab.waiver?).to eq(false)
      expect(waiver.waiver?).to eq(true)
    end
  end
end
