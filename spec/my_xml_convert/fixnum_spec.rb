require "spec_helper"

describe MyXmlConvert::Fixnum do
    it "returns the String value of Numbers" do
      n = 10
      expect(MyXmlConvert::Fixnum.fixnum_to_xml("test",n)).to eq("10")
    end

     it "returns the String value of decimal Numbers" do
      n = 10.23
      expect(MyXmlConvert::Fixnum.fixnum_to_xml("test",n)).to eq("10.23")
    end
end