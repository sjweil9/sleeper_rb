RSpec.describe SleeperRb::Utilities::Cache do
  subject do
    Class.new do
      include SleeperRb::Utilities::Cache
    end
  end

  before { subject.lazy_attr_reader(:foo) }
  let(:instance) { subject.new }

  describe "::lazy_attr_reader" do
    it "extends as a class method" do
      expect(subject).to respond_to(:lazy_attr_reader)
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
        instance.instance_variable_set(:@values, { "foo" => 123 })
        expect(instance.foo).to eq(123)
        expect(instance.instance_variable_get(:@foo)).to eq(123)
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
  end
end