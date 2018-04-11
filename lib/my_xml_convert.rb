require "my_xml_convert/version"
require "my_xml_convert/ObjtoXML"
require "my_xml_convert/key"

module MyXmlConvert

  #translates a given object to an XML.
  def self.to_xml(obj, options = {})
  	ObjtoXML.to_xml(obj, options)
  end

  # Converts a given Hash key with options into an XML key.
  def self.xml_tag(key, options = {})
    MyXmlConvert::Key.create(key, options)
  end

end



