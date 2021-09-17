# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::DraftArray do
  subject { described_class.new(drafts) }

  let(:drafts) do
    json = File.read(File.expand_path("../../fixtures/drafts_response.json", File.dirname(__FILE__)))
    parsed = JSON.parse(json, symbolize_names: true)
    parsed.map { |hash| SleeperRb::Resources::Draft.new(hash) }
  end

  describe "#auction" do
    let(:auction_ids) { %w[737553266170281984 737785377116553216] }

    it "should return all auction drafts" do
      expect(subject.auction.map(&:draft_id).sort).to eq(auction_ids.sort)
    end
  end

  describe "#snake" do
    let(:snake_ids) { %w[737327332259409920 735284283798888448] }

    it "should return all snake drafts" do
      expect(subject.snake.map(&:draft_id).sort).to eq(snake_ids.sort)
    end
  end
end
