# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::PlayerArray do
  subject { described_class.new(SleeperRb::Resources::Player.all) }

  it "should provide methods for each valid roster position to filter the array" do
    SleeperRb::Utilities::RosterPosition::VALID_ROSTER_POSITIONS.each do |position|
      expect(subject.send(position)).to be_an_instance_of(described_class)
      expect(subject.send(position).all? { |player| player.position == position }).to eq(true)
    end
  end
end
