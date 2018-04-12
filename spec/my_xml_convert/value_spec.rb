require "spec_helper"

describe MyXmlConvert::Value do

  describe ".create" do

    context "for DateTime objects" do
      it "returns an xs:dateTime compliant String" do
        name = "hello"
        d = DateTime.new(2012, 03, 22, 16, 22, 33)
        expect(MyXmlConvert::Value.create(name,d)).to eq("2012-03-22T16:22:33+00:00")
      end
    end

    context "for Date objects" do
      it "returns an xs:date compliant String" do
        name = "hello"
        d = Date.new(2012, 03, 22)
        expect(MyXmlConvert::Value.create(name,d)).to eq("2012-03-22")
      end
    end

    context "for Time objects" do
      it "returns an xs:time compliant String" do
        name = "hello"
        t = Time.local(2012, 03, 22, 16, 22, 33)
        expect(MyXmlConvert::Value.create(name,t)).to eq("16:22:33")
      end
    end

    it "hash objects get converted to xml" do
      object = {:a=>"a"}
      name = "hello"
      expect(MyXmlConvert::Value.create(name,object)).to eq("<a>a</a>")
    end

    it "array objects get converted to xml" do
      object = [1,2,3]
      name = "hello"
      expect(MyXmlConvert::Value.create(name,object)).to eq("<hello>1</hello><hello>2</hello><hello>3</hello>")
    end

    it "calls to_s unless the Object doesn't match any other criteria" do
      expect(MyXmlConvert::Value.create("hello","value")).to eq("value")
    end
  end

end
