# frozen_string_literal: true

RSpec.describe SleeperRb::Utilities::Cache do
  subject do
    Class.new do
      include SleeperRb::Utilities::Cache
    end
  end

  before do
    subject.cached_attr(:foo)
    subject.cached_association(:bar) do
      BarAssociation.call
    end
    subject.cached_association(:qux) do |num|
      QuxAssociation.call(num)
    end
  end
  let(:instance) { subject.new }

  describe "::cached_attr" do
    it "extends as a class method" do
      expect(subject).to respond_to(:cached_attr)
    end

    context "when ivar is defined" do
      it "returns the named ivar" do
        expect(instance).not_to receive(:values)
        instance.instance_variable_set(:@foo, nil)
        expect(instance.foo).to be_nil

        instance.instance_variable_set(:@foo, "abc")
        expect(instance.foo).to eq("abc")
      end
    end

    context "when ivar is not defined" do
      it "sets the ivar from values" do
        expect(instance).to receive(:values).and_call_original
        instance.instance_variable_set(:@values, { foo: 123 })
        expect(instance.foo).to eq(123)
        expect(instance.instance_variable_get(:@foo)).to eq(123)
      end
    end

    context "when provided attr is a key/value pair" do
      before { subject.cached_attr(bar: ->(x) { x.to_i + 3 }) }

      it "should use the value as a translation for the key" do
        instance.instance_variable_set(:@values, { bar: 3 })
        expect(instance.bar).to eq(6)
        expect(instance.instance_variable_get(:@bar)).to eq(6)
      end
    end
  end

  describe "::association" do
    it "extends as a class method" do
      expect(subject).to respond_to(:cached_association)
    end

    context "no arguments are provided" do
      it "memoizes the value returned by the block provided when defining the association" do
        expect(BarAssociation).to receive(:call).once.and_call_original
        2.times { expect(instance.bar).to eq(%w[A B C]) }
      end
    end

    context "arguments are provided" do
      it "memoizes the value by argument" do
        expect(QuxAssociation).to receive(:call).twice.and_call_original
        2.times { expect(instance.qux(5)).to eq(10) }
        2.times { expect(instance.qux(2)).to eq(4) }
      end
    end
  end

  describe "#values" do
    let(:values) { { "foo" => 123 } }

    context "ivar is defined" do
      before { instance.instance_variable_set(:@values, values) }

      it "returns the ivar" do
        expect(instance).not_to receive(:retrieve_values!)
        expect(instance.send(:values)).to eq(values)
      end
    end

    context "ivar is not defined" do
      it "sets the ivar with retrieve_values!" do
        expect(instance).to receive(:retrieve_values!).and_return(values)
        expect(instance.send(:values)).to eq(values)
      end
    end
  end

  describe "#refresh" do
    it "should reset values and return the instance" do
      expect(instance).to receive(:retrieve_values!).and_return({})
      expect(instance.refresh).to eq(instance)
    end

    it "should reset cached_associations" do
      expect(instance).to receive(:retrieve_values!).and_return({})
      instance.instance_variable_set(:@cached_associations, { a: 2 })
      expect(instance.refresh).to eq(instance)
      expect(instance.instance_variable_get(:@cached_associations)).to eq({})
    end
  end
end
