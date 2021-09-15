# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft do
  let(:valid_opts) do
    json = File.read(File.expand_path("../../fixtures/draft_response.json", File.dirname(__FILE__)))
    JSON.parse(json, symbolize_names: true)
  end

  subject { described_class.new(valid_opts) }

  describe "#initialize" do
    let(:translated_keys) { %i[settings metadata] }

    it "should set the proper values" do
      valid_opts.reject { |key, _val| translated_keys.include?(key) }.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end

      expect(subject.settings).to be_an_instance_of(SleeperRb::Resources::Draft::Settings)
      expect(subject.metadata).to be_an_instance_of(SleeperRb::Resources::Draft::Metadata)
    end
  end
end
