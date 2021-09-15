# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft do
  let(:valid_opts) { JSON.parse(response_json, symbolize_names: true) }
  let(:response_json) do
    File.read(File.expand_path("../../fixtures/draft_response.json", File.dirname(__FILE__)))
  end
  let(:translated_keys) { %i[settings metadata] }
  let(:draft_id) { "737785377116553216" }

  before do
    stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/draft/#{draft_id}").to_return(body: response_json)
  end

  describe "#initialize" do
    subject { described_class.new(valid_opts) }

    it "should set the proper values" do
      valid_opts.reject { |key, _val| translated_keys.include?(key) }.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end

      expect(subject.settings).to be_an_instance_of(SleeperRb::Resources::Draft::Settings)
      expect(subject.metadata).to be_an_instance_of(SleeperRb::Resources::Draft::Metadata)
    end
  end

  describe "#retrieve_values!" do
    subject { described_class.new(draft_id: draft_id) }

    it "should set proper values" do
      expect(subject).to receive(:retrieve_values!).and_call_original
      valid_opts.reject { |key, _val| translated_keys.include?(key) }.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end

      expect(subject.settings).to be_an_instance_of(SleeperRb::Resources::Draft::Settings)
      expect(subject.metadata).to be_an_instance_of(SleeperRb::Resources::Draft::Metadata)
    end
  end
end
