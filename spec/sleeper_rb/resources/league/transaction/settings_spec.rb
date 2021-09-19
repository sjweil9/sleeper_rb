# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::League::Transaction::Settings do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
      waiver_bid: 45
    }
  end

  describe "#initialize" do
    it "should set the proper values" do
      valid_opts.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end
    end
  end
end
