# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League::Roster::Settings do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
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
    }
  end

  describe "#initialize" do
    it "should set the proper values" do
      valid_opts.each do |key, val|
        expect(subject.send(key)).to eq(val)
      end
    end
  end

  describe "#total_points" do
    it "should return the sum of fpts and decimal" do
      expect(subject.total_points).to eq(100.25)
    end
  end

  describe "#total_points_against" do
    it "should return the sum of fpts_against and decimal" do
      expect(subject.total_points_against).to eq(105.83)
    end
  end

  describe "#win_pct" do
    it "should return wins as a percentage of total games" do
      expect(subject.win_pct).to eq(50.0)
    end
  end

  describe "#record_string" do
    it "should return the record in W - L - T format" do
      expect(subject.record_string).to eq("3 - 2 - 1")
    end
  end
end
