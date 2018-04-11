require "my_xml_convert/value"
require "my_xml_convert/key"

module MyXmlConvert
	class Hash

		def self.hash_to_xml(name="",obj, options = {} )
			xmlstring=""
			for i in obj.keys do
				
				key = MyXmlConvert::Key.create(i,options)
				name = key
				value = MyXmlConvert::Value.create(name,obj[i],options)
		
				xmlstring+= "<" + key + ">" + value + "</" + key + ">" 
					
			end
			return xmlstring
		end
	end
end
