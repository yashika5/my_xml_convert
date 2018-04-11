require 'my_xml_convert'
require 'my_xml_convert/ObjtoXML'

describe MyXmlConvert.to_xml do

  it "array to xml" do
    @book = [1,2,3,4,5]
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Array>\n<book>\n   <book>1</book>\n   <book>2</book>\n   <book>3</book>\n   <book>4</book>\n   <book>5</book>\n<\\book>\n<\\Array>\"\n")
  end

  it "hash to xml" do
    @book = {"1"=>1,"2"=>2,"3"=>3}
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Hash>\n<book>\n   <1>1</1>\n   <2>2</2>\n   <3>3</3>\n<\\book>\n<\\Hash>\"\n")
  end

  it "fixnum to xml" do
    @book = 3
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Fixnum>\n<book>\n   <book>3</book>\n<\\book>\n<Fixnum>\"\n")
  end
 
  it "string to xml" do
    @book = "a"
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<String>\n<book>\n   <book>a</book>\n<\\book>\n<String>\"\n")
  end

  it "array inside array to xml" do
    @book = [1,2,[1,2,3]]
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Array>\n<book>\n   <book>1</book>\n   <book>2</book>\n   <book>\n      <book>1</book>\n      <book>2</book>\n      <book>3</book>\n   </book>\n<\\book>\n<\\Array>\"\n")
  end

  it "hash inside array to xml" do
    @book = [1,2,{"1"=>1}]
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Array>\n<book>\n   <book>1</book>\n   <book>2</book>\n   <book>\n      <1>1</1>\n   </book>\n<\\book>\n<\\Array>\"\n")
  end

  it "array inside hash to xml" do
    @book = {"1"=>[1,2,3],"2"=>2}
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Hash>\n<book>\n   <1>\n      <1>1</1>\n      <1>2</1>\n      <1>3</1>\n   </1>\n   <2>2</2>\n<\\book>\n<\\Hash>\"\n")
  end

  it "hash inside hash to xml" do
    @book = {"1"=>{"1"=>1,"2"=>2},"3"=>3}
    expect(My_xml_convert::My_to_xml.to_xml("book",@book)).to eql("<?xml version=\"1.0\"encoding=\"UTF-8\"?>\n<Hash>\n<book>\n   <1>\n      <1>1</1>\n      <2>2</2>\n   </1>\n   <3>3</3>\n<\\book>\n<\\Hash>\"\n")
  end

end
