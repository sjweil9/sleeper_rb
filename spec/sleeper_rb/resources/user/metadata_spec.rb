# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::User::Metadata do
  describe "#initialize" do
    subject { described_class.new(valid_opts) }

    let(:valid_opts) do
      {
        team_name: "Foo Team"
      }
    end

    it "should set the proper values" do
      expect(subject.team_name).to eq("Foo Team")
    end
  end
end
