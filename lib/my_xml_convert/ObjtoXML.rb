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

				if options[:type] == "Hash"
					xmlstring+= "<Hash>"
					xmlstring+= MyXmlConvert::Hash.hash_to_xml(obj, options)
					xmlstring+= "</Hash>"
				elsif obj.class == Array
					xmlstring+= "<Array>"
					xmlstring+= MyXmlConvert::Array.array_to_xml(obj, options)
					xmlstring+= "</Array>"
				elsif obj.class == String
					xmlstring+= "<String>"
					xmlstring+= MyXmlConvert::String.string_to_xml(obj,options)
					xmlstring+= "</String>"
				elsif obj.class == Fixnum
					xmlstring+= "<Fixnum>"
					xmlstring+= MyXmlConvert::Fixnum.fixnum_to_xml(obj, options)
					xmlstring+= "</Fixnum>"
				else
					xmlstring+= "<Object>"
                    value = MyXmlConvert::Value.create(obj,options)
					xmlstring+= value.to_s
                    xmlstring+= "</Object>"
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
