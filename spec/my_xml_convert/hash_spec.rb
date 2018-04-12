require "spec_helper"

describe MyXmlConvert::Hash do

  describe ".hash_to_xml" do
    it "for a simple Hash" do
        expect(MyXmlConvert::Hash.hash_to_xml("test",{:some => "user"})).to eq("<some>user</some>")
      end

    it "for a nested Hash" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:some => { :new => "user" }})).to eq("<some><new>user</new></some>")
    end

    context "with key_converter" do
      it "expect all keys change" do
        expect(MyXmlConvert::Hash.hash_to_xml("test",{:some => { :new => "user" }}, {key_converter: :camelcase})).to eq("<Some><New>user</New></Some>")
      end

      it "and key_to_convert option should change only key" do
        hash = {:some => { :new => "user", :age => 20 }}
        options = {key_converter: :camelcase, key_to_convert: "some"}
        result = "<Some><new>user</new><age>20</age></Some>"
        expect(MyXmlConvert::Hash.hash_to_xml("test",hash, options)).to eq(result)

        hash = {:some => { :new => "user", :age => 20 }}
        options = {key_converter: :camelcase, key_to_convert: "new"}
        result = "<some><New>user</New><age>20</age></some>"
        expect(MyXmlConvert::Hash.hash_to_xml("test",hash, options)).to eq(result)
      end

      it "with except option, dont convert this key" do
        hash = {:some => { :new => "user", :age => 20 }}
        options = {key_converter: :camelcase, except: "some"}
        result = "<some><New>user</New><Age>20</Age></some>"
        expect(MyXmlConvert::Hash.hash_to_xml("test",hash, options)).to eq(result)
      end
    end

    it "for a Hash with multiple keys" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:all => "users", :before => "whatever"})).to include(
        "<all>users</all>",
        "<before>whatever</before>"
      )
    end

    it "for a Hash containing an Array" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:some => ["user", "gorilla"]})).to eq("<some><some>user</some><some>gorilla</some></some>")
    end

    it "for a Hash containing an Array of Hashes" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:some => [{ :new => "user" }, { :old => "gorilla" }]})).to eq("<some><some><new>user</new></some><some><old>gorilla</old></some></some>")
    end

    it "converts Hash key Symbols to lowerCamelCase" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:find_or_create => "user"})).to eq("<findOrCreate>user</findOrCreate>")
    end

    it "does not convert Hash key Strings" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{"find_or_create" => "user"})).to eq("<find_or_create>user</find_or_create>")
    end

    it "converts DateTime objects to xs:dateTime compliant Strings" do
      expect(MyXmlConvert::Hash.hash_to_xml("test",{:before => DateTime.new(2012, 03, 22, 16, 22, 33)})).
        to eq("<before>2012-03-22T16:22:33+00:00</before>")
    end

    it "defaults to escape special characters" do
      result = MyXmlConvert::Hash.hash_to_xml("test",{:some => { :nested => "<tag/>" }, :tag => "<tag/>"})
      expect(result).to include("<tag>&lt;tag /&gt;</tag>")
      expect(result).to include("<some><nested>&lt;tag /&gt;</nested></some>")
    end
  end
end
