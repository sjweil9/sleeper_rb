# frozen_string_literal: true

RSpec.describe SleeperRb::Utilities::Cache do
  subject do
    Class.new do
      include SleeperRb::Utilities::Cache
    end
  end

  before do
    subject.cached_attr(:foo)
    subject.cached_association :bar do
      BarAssociation.call
    end
    subject.cached_association :qux do |num|
      QuxAssociation.call(num)
    end
  end
  let(:instance) { subject.new }

  describe "::cached_attr" do
    it "extends as a class method" do
      expect(subject).to respond_to(:cached_attr)
    end

    context "when ivar is present" do
      it "returns the named ivar" do
        expect(instance).not_to receive(:values)
        instance.instance_variable_set(:@foo, "abc")
        expect(instance.foo).to eq("abc")
      end
    end

    context "when ivar is not present" do
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

    context "when value is :int_to_bool" do
      before { subject.cached_attr(bar: :int_to_bool, foo: :int_to_bool) }

      it "should convert to boolean" do
        instance.instance_variable_set(:@values, { bar: 0, foo: 1 })
        expect(instance.bar).to eq(false)
        expect(instance.foo).to eq(true)
      end
    end

    context "when value is :float" do
      before { subject.cached_attr(bar: :float) }

      let(:float_value) { 10.45215 }

      it "should round to 2 places" do
        instance.instance_variable_set(:@values, { bar: float_value })
        expect(instance.bar).to eq(float_value.round(2))
      end
    end

    context "when value is :timestamp" do
      before { subject.cached_attr(bar: :timestamp) }

      let(:epoch) { 1_631_920_216_549 }

      it "should convert to a Time in UTC" do
        instance.instance_variable_set(:@values, { bar: epoch })
        expect(instance.bar).to eq(Time.at(epoch / 1000).utc)
      end
    end
  end

  describe "::cached_association" do
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

  describe "::skip_refresh" do
    before do
      subject.cached_attr(:baz, :qaz)
      instance.instance_variable_set(:@foo, "foo")
      instance.instance_variable_set(:@baz, "baz")
      instance.instance_variable_set(:@qaz, "qaz")
    end

    context "specific field is provided" do
      before { subject.skip_refresh(:baz) }

      it "should exclude the specified field from refresh" do
        instance.refresh
        expect(instance.instance_variable_get(:@foo)).to be_nil
        expect(instance.instance_variable_get(:@baz)).to eq("baz")
        expect(instance.instance_variable_get(:@qaz)).to be_nil
      end
    end

    context "multiple fields are provided" do
      before { subject.skip_refresh(:foo, :baz) }

      it "should exclude specified fields from refresh" do
        instance.refresh
        expect(instance.instance_variable_get(:@foo)).to eq("foo")
        expect(instance.instance_variable_get(:@baz)).to eq("baz")
        expect(instance.instance_variable_get(:@qaz)).to be_nil
      end
    end

    context ":all is provided" do
      before { subject.skip_refresh(:all) }

      it "should exclude all fields from refresh" do
        instance.refresh
        expect(instance.instance_variable_get(:@foo)).to eq("foo")
        expect(instance.instance_variable_get(:@baz)).to eq("baz")
        expect(instance.instance_variable_get(:@qaz)).to eq("qaz")
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
      instance.instance_variable_set(:@foo, "abc")
      expect(instance).to receive(:retrieve_values!).and_return({})
      expect(instance.refresh).to eq(instance)
      expect(instance.instance_variable_get(:@foo)).to be_nil
      expect(instance.send(:values)).to eq({})
    end

    it "should reset cached_associations" do
      instance.instance_variable_set(:@cached_associations, { a: 2 })
      expect(instance.refresh).to eq(instance)
      expect(instance.instance_variable_get(:@cached_associations)).to eq({})
    end
  end
end
