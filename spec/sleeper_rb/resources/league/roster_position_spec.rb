# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League::RosterPosition do
  subject { described_class.new("QB") }

  it "should define introspective methods to check roster position" do
    expect(subject.qb?).to eq(true)
    described_class::VALID_ROSTER_POSITIONS.reject { |pos| pos == "qb" }.each do |position|
      expect(subject.send("#{position}?")).to eq(false)
    end
  end
end
