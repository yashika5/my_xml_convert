require "spec_helper"

describe MyXmlConvert::String do
	it "returns the String value and escapes special characters" do
      expect(MyXmlConvert::String.string_to_xml("string","string")).to eq("string")
      expect(MyXmlConvert::String.string_to_xml("string","<tag>")).to eq("&lt;tag&gt;")
      expect(MyXmlConvert::String.string_to_xml("string","at&t")).to eq("at&amp;t")
      expect(MyXmlConvert::String.string_to_xml("string",'"quotes"')).to eq("&quot;quotes&quot;")
    end

    it "returns the String value without escaping special characters" do
      options = {:escape_xml => false}
      expect(MyXmlConvert::String.string_to_xml("string","<tag>", options)).to eq("<tag>")
    end
end