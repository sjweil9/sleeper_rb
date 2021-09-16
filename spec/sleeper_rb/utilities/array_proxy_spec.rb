# frozen-string-literal: true

RSpec.describe SleeperRb::Utilities::ArrayProxy do
  subject { described_class.new(foos) }

  let(:foos) do
    5.times.map do |i|
      Class.new do
        attr_reader :bar, :qux

        def initialize(bar:, qux:)
          @bar = bar
          @qux = qux
        end
      end.new(bar: i + 1, qux: 5 - i)
    end
  end

  describe "#where" do
    context "with key/value pairs" do
      it "returns all elements that match" do
        result = subject.where(bar: 1, qux: 5)
        expect(result).to be_an_instance_of(described_class)
        expect(result.first.bar).to eq(1)
        expect(result.first.qux).to eq(5)
      end
    end

    context "with an lt operator" do
      it "returns all elements that match" do
        result = subject.where(bar: { lt: 3 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar < 3 }).to eq(true)
      end
    end

    context "with an lte operator" do
      it "returns all elements that match" do
        result = subject.where(bar: { lte: 3 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar <= 3 }).to eq(true)
      end
    end

    context "with an lt operator" do
      it "returns all elements that match" do
        result = subject.where(bar: { gt: 3 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar > 3 }).to eq(true)
      end
    end

    context "with an lt operator" do
      it "returns all elements that match" do
        result = subject.where(bar: { gte: 3 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar >= 3 }).to eq(true)
      end
    end

    context "with an lt operator" do
      it "returns all elements that match" do
        result = subject.where(bar: { not: 3 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar != 3 }).to eq(true)
      end
    end

    context "with multiple operators" do
      it "returns all elements that match the combination" do
        result = subject.where(bar: { lt: 4, gt: 2 }, qux: { lte: 4 })
        expect(result).to be_an_instance_of(described_class)
        expect(result.all? { |el| el.bar < 4 && el.bar > 2 && el.qux <= 4 }).to eq(true)
      end
    end

    context "with an invalid operator" do
      it "raises ArgumentError" do
        expect { subject.where(bar: { asdf: 3 }) }.to raise_error(ArgumentError)
      end
    end

    context "with an invalid field" do
      it "raises NoMethodError" do
        expect { subject.where(asdf: 3) }.to raise_error(NoMethodError)
      end
    end
  end
end
