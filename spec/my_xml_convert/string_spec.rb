require "spec_helper"

describe MyXmlConvert::String do
	it "returns the String value and escapes special characters" do
      expect(MyXmlConvert::String.string_to_xml("string")).to eq("string")
      expect(MyXmlConvert::String.string_to_xml("<tag>")).to eq("&lt;tag&gt;")
      expect(MyXmlConvert::String.string_to_xml("at&t")).to eq("at&amp;t")
      expect(MyXmlConvert::String.string_to_xml('"quotes"')).to eq("&quot;quotes&quot;")
    end

    it "returns the String value without escaping special characters" do
      expect(MyXmlConvert::String.string_to_xml("<tag>", false)).to eq("<tag>")
    end
end