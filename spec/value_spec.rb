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
        expect(create(Date.new(2012, 03, 22))).to eq("2012-03-22")
      end
    end

    context "for Time objects" do
      it "returns an xs:time compliant String" do
        expect(create(Time.local(2012, 03, 22, 16, 22, 33))).to eq("16:22:33")
      end
    end

    it "returns an xs:dateTime compliant String for Objects responding to #to_datetime" do
      singleton = Object.new
      def singleton.to_datetime
        DateTime.new 2012, 03, 22, 16, 22, 33
      end
      expect(create(singleton)).to eq("2012-03-22T16:22:33+00:00")
    end

    it "calls Proc objects and converts their return value" do
      object = lambda { DateTime.new 2012, 03, 22, 16, 22, 33 }
      expect(create(object)).to eq("2012-03-22T16:22:33+00:00")
    end

    it "hash objects get converted to xml" do
      object = {:a=>"a"}
      expect(create(object)).to eq("<Hash><a>a</a></Hash>")
    end

    it "calls #to_s unless the Object responds to #to_datetime" do
      expect(create("value")).to eq("value")
    end
  end

  def create(name , object, options = {})
    MyXmlConvert::Value.create(name,object,options)
  end

end
