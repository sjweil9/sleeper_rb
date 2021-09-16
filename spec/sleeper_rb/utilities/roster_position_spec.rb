# frozen_string_literal: true

RSpec.describe SleeperRb::Utilities::RosterPosition do
  subject { described_class.new("QB") }

  it "should define introspective methods to check roster position" do
    expect(subject.qb?).to eq(true)
    described_class::VALID_ROSTER_POSITIONS.reject { |pos| pos == "qb" }.each do |position|
      expect(subject.send("#{position}?")).to eq(false)
    end
  end

  describe "==" do
    it "should compare itself against raw strings" do
      expect(subject).to eq("qb")
    end

    it "should compare itself against other RosterPosition objects" do
      expect(subject).to eq(described_class.new("QB"))
    end
  end
end
