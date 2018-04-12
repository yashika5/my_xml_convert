require "spec_helper"

describe MyXmlConvert::Array do

  describe ".array_to_xml" do
    it "for a simple Array" do
        expect(MyXmlConvert::Array.array_to_xml("test",[1,2,3])).to eq("<test>1</test><test>2</test><test>3</test>")
      end

    it "for a nested Array" do
      expect(MyXmlConvert::Array.array_to_xml("test",[1,2,[3,4,5]])).to eq("<test>1</test><test>2</test><test><test>3</test><test>4</test><test>5</test></test>")
    end

    it "for a Array containing an Hash" do
      expect(MyXmlConvert::Array.array_to_xml("test",[1,2,{:a=>3}])).to eq("<test>1</test><test>2</test><test><a>3</a></test>")
    end

    it "for a Array containing a Hash of Arrays" do
      expect(MyXmlConvert::Array.array_to_xml("test",[{:a=>[1,2,3],:b=>2},5])).to eq("<test><a><a>1</a><a>2</a><a>3</a></a><b>2</b></test><test>5</test>")
    end

    it "converts Hash key Symbols to lowerCamelCase" do
      expect(MyXmlConvert::Array.array_to_xml("test",[{:find_or_create => "user"}])).to eq("<test><findOrCreate>user</findOrCreate></test>")
    end

    it "does not convert Hash key Strings" do
      expect(MyXmlConvert::Array.array_to_xml("test",[{"find_or_create" => "user"}])).to eq("<test><find_or_create>user</find_or_create></test>")
    end

    it "converts DateTime objects to xs:dateTime compliant Strings" do
      expect(MyXmlConvert::Array.array_to_xml("test",[DateTime.new(2012, 03, 22, 16, 22, 33)])).
        to eq("<test>2012-03-22T16:22:33+00:00</test>")
    end

    it "defaults to escape special characters" do
      result = MyXmlConvert::Array.array_to_xml("test",["<tag/>",'"quotes"'])
      expect(result).to include("<test>&lt;tag/&gt;</test>")
      expect(result).to include("<test>&quot;quotes&quot;</test>")
    end

    it "calls to_s on any other Object" do
      [true, false].each do |object|
        expect(MyXmlConvert::Array.array_to_xml("test",[object])).to eq("<test>#{object}</test>")
      end
    end

    context "with key_converter" do
      it "expect all keys change" do
        expect(MyXmlConvert::Array.array_to_xml("test",[{:some => { :new => "user" }}], {key_converter: :camelcase})).to eq("<test><Some><New>user</New></Some></test>")
      end

      it "and key_to_convert option should change only key" do
        array = [{:some => { :new => "user", :age => 20 }}]
        options = {key_converter: :camelcase, key_to_convert: "some"}
        result = "<test><Some><new>user</new><age>20</age></Some></test>"
        expect(MyXmlConvert::Array.array_to_xml("test",array, options)).to eq(result)

        array = [{:some => { :new => "user", :age => 20 }}]
        options = {key_converter: :camelcase, key_to_convert: "new"}
        result = "<test><some><New>user</New><age>20</age></some></test>"
        expect(MyXmlConvert::Array.array_to_xml("test",array, options)).to eq(result)
      end

      it "with except option, dont convert this key" do
        array = [{:some => { :new => "user", :age => 20 }}]
        options = {key_converter: :camelcase, except: "some"}
        result = "<test><some><New>user</New><Age>20</Age></some></test>"
        expect(MyXmlConvert::Array.array_to_xml("test",array, options)).to eq(result)
      end
    end

  end
end
