# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::LeagueArray do
  subject { described_class.new(leagues) }

  let(:leagues) do
    json = File.read(File.expand_path("../../fixtures/leagues_response.json", File.dirname(__FILE__)))
    parsed = JSON.parse(json, symbolize_names: true)
    parsed.map { |hash| SleeperRb::Resources::League.new(hash) }
  end

  describe "#best_ball" do
    let(:best_ball_ids) { %w[737785373232623616 735284283123548160 737553262500306944] }

    it "should return all best ball leagues" do
      expect(subject.best_ball.map(&:league_id).sort).to eq(best_ball_ids.sort)
    end
  end

  describe "#ppr" do
    let(:ppr_ids) { %w[737785373232623616 737553262500306944] }

    it "should return all ppr leagues" do
      expect(subject.ppr.map(&:league_id).sort).to eq(ppr_ids.sort)
    end
  end

  describe "#half_ppr" do
    let(:half_ppr_ids) { ["737327330413969408"] }

    it "should return all half ppr leagues" do
      expect(subject.half_ppr.map(&:league_id)).to eq(half_ppr_ids)
    end
  end

  describe "#standard" do
    let(:standard_ids) { ["735284283123548160"] }

    it "should return all standard leagues" do
      expect(subject.standard.map(&:league_id)).to eq(standard_ids)
    end
  end
end
