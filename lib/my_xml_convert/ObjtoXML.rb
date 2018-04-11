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
				name = "xml"
				name = options[:name] if options[:name]				

				if ::Hash === obj
					xmlstring+= "<Hash>"
					xmlstring+= MyXmlConvert::Hash.hash_to_xml(name,obj, options)
					xmlstring+= "</Hash>"
				elsif ::Array === obj
					xmlstring+= "<Array>"
					xmlstring+= MyXmlConvert::Array.array_to_xml(name,obj, options)
					xmlstring+= "</Array>"
				elsif ::String === obj
					xmlstring+= "<String>"
					xmlstring+= MyXmlConvert::String.string_to_xml(name,obj,options)
					xmlstring+= "</String>"
				elsif ::Fixnum === obj
					xmlstring+= "<Fixnum>"
					xmlstring+= MyXmlConvert::Fixnum.fixnum_to_xml(name,obj, options)
					xmlstring+= "</Fixnum>"
				else
					xmlstring+= "<Object>"
                    value = MyXmlConvert::Value.create(name,obj,options)
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
