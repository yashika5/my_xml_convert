require "my_xml_convert/pretty"
require "my_xml_convert/hash"
require "my_xml_convert/array"
require "my_xml_convert/string"
require "my_xml_convert/fixnum"
require "my_xml_convert/value"

module MyXmlConvert
	class ObjtoXML

		public

			def self.to_xml(obj, options = {} )

				xmlstring = "" 
				xmlstring+= "<?xml version=\"1.0\"encoding=\"UTF-8\"?>" if options[:header]
				xmlstring+= "<" + options[:name] + ">" if options[:name]				

				if obj.class == Hash
					xmlstring+= "<Hash>"
					xmlstring+= MyXmlConvert::Hash.hash_to_xml(obj, options)
					xmlstring+= "</Hash>"
				end

				xmlstring+= "</" + options[:name] + ">" if options[:name]
				if options[:pretty_print]
           				return MyXmlConvert::Pretty.prettify(xmlstring, options)
      				else
        				return xmlstring
      				end

				return xmlstring

			end
	end
end
