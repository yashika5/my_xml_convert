require "spec_helper"

describe MyXmlConvert::Pretty do
  describe "#prettify" do
    context "when xml is valid" do
      name = "test"
      let!(:xml) { MyXmlConvert::Hash.hash_to_xml(name, { test: { pretty: "xml" }}) }

      it "returns prettified xml" do
        expect(MyXmlConvert::Pretty.prettify(xml)).to eql("<test>\n   <pretty>xml</pretty>\n</test>")
      end

      context "when indent option is specified" do
        it "returns prettified xml with indent" do
          options = { indent: 3 }
          expect(MyXmlConvert::Pretty.prettify(xml,options)).to eql("<test>\n   <pretty>xml</pretty>\n</test>")
        end
      end

      context "when compact option is specified" do
        it "returns prettified xml with indent" do
          options = { compact: false }
          expect(MyXmlConvert::Pretty.prettify(xml,options)).to eql("<test>\n   <pretty>\n      xml\n   </pretty>\n</test>")
        end
      end
    end

    context "when xml is not valid" do
      let!(:xml) do
        MyXmlConvert::Array.array_to_xml("hello",["one", "two"])
      end

      it "raises an error" do
        expect{ MyXmlConvert::Pretty.prettify(xml) }.to raise_error REXML::ParseException
      end
    end
  end
end
