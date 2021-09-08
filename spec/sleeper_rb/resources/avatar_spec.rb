# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::Avatar do
  let(:headers) do
    {
      "Content-Type" => "image/png",
      "Content-Length" => 5053
    }
  end
  let(:avatar_id) { "ABC123CYZ" }
  let(:file) { File.read(File.expand_path("../../fixtures/test_image.png", File.dirname(__FILE__))) }
  let(:file_response) { RESPONSE.new("200", file) }

  subject { described_class.new(avatar_id) }

  describe "#retrieve_values!" do
    it "should set all proper values" do
      allow_any_instance_of(Net::HTTP).to receive(:get).and_return(file_response)
      expect(subject.avatar_id).to eq(avatar_id)
      expect(subject.full_size).to be_an_instance_of(Tempfile)
      expect(subject.thumbnail).to be_an_instance_of(Tempfile)
    end
  end
end
