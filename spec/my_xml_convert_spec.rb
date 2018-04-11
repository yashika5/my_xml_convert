require 'my_xml_convert'
require "my_xml_convert/ObjtoXML"

describe "MyXmlConvert.to_xml" do

  it "array to xml" do
    book = [1,2,3,4,5]
    expect(MyXmlConvert.to_xml(book)).to eql("<Array><array>1</array><array>2</array><array>3</array><array>4</array><array>5</array></Array>")
  end


  it "hash to xml" do
    book = {"1"=>1,"2"=>2,"3"=>3}
    expect(MyXmlConvert.to_xml(book)).to eql("<Hash><1>1</1><2>2</2><3>3</3></Hash>")
  end

  it "fixnum to xml" do
    book = 3
    expect(MyXmlConvert.to_xml(book)).to eql("<Fixnum>3</Fixnum>")
  end
 
  it "string to xml" do
    book = "a"
    expect(MyXmlConvert.to_xml(book)).to eql("<String>a</String>")
  end

  it "array inside array to xml" do
    book = [1,2,[1,2,3]]
    expect(MyXmlConvert.to_xml(book)).to eql("<Array><array>1</array><array>2</array><array><array>1</array><array>2</array><array>3</array></array></Array>")
  end

  it "hash inside array to xml" do
    book = [1,2,{"1"=>1}]
    expect(MyXmlConvert.to_xml(book)).to eql("<Array><array>1</array><array>2</array><array><1>1</1></array></Array>")
  end

  it "array inside hash to xml" do
    book = {"1"=>[1,2,3],"2"=>2}
    expect(MyXmlConvert.to_xml(book)).to eql("<Hash><1><1>1</1><1>2</1><1>3</1></1><2>2</2></Hash>")
  end

  it "hash inside hash to xml" do
    book = {"1"=>{"1"=>1,"2"=>2},"3"=>3}
    expect(MyXmlConvert.to_xml(book)).to eql("<Hash><1><1>1</1><2>2</2></1><3>3</3></Hash>")
  end

  it "accepts a key_converter for the Hash keys" do
    hash = { :user_name => "finn", :pass_word => "secret" }
    xml = MyXmlConvert.to_xml(hash, {key_converter: :upcase})

    expect(xml).to include("<USER_NAME>finn</USER_NAME>")
    expect(xml).to include("<PASS_WORD>secret</PASS_WORD>")
  end

end

describe "MyXmlConvert.xml_tag" do
  
  it "translates Symbols to lowerCamelCase by default" do
    tag = MyXmlConvert.xml_tag(:user_name)
    expect(tag).to eq("userName")
  end

  it "does not translate Strings" do
    tag = MyXmlConvert.xml_tag("user_name")
    expect(tag).to eq("user_name")
  end

  it "translates Symbols by a given key_converter" do
    tag = MyXmlConvert.xml_tag(:user_name, :key_converter => :upcase)
    expect(tag).to eq("USER_NAME")
  end

  it "does not translates Strings with a given key_converter" do
    tag = MyXmlConvert.xml_tag("user_name", :key_converter => :upcase)
    expect(tag).to eq("user_name")
  end

end
