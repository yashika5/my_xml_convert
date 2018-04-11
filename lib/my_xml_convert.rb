require "my_xml_convert/version"
require "my_xml_convert/ObjtoXML"

module MyXmlConvert

  #translates a given object to an XML.
  def self.to_xml(obj, options = {})
  	puts a if obj.is_a?(Array)
  	ObjtoXML.to_xml(obj, options)
  end

end



